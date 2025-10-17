terraform {
  required_providers {
    ctcloud = {
      source = "www.ctyun.cn/ctyun/ctcloud"
      version = ">=1.0.0"
    }
  }
}

provider "ctcloud" {
  ak                = var.ak
  sk                = var.sk
  env               = var.env
  region_id         = var.region_id
  master_order_id   = var.master_order_id
  paas_resource_id  = var.paas_resource_id
  account_id        = var.account_id
  user_id           = var.user_id
}

locals {
  security_rule_map = var.security_rules == null ? {} : { for idx, rule in tolist(var.security_rules) : "item-${idx}" => rule }
  business_security_rule_map = var.business_security_rules == null ? {} : { for idx, rule in tolist(var.business_security_rules) : "item-${idx}" => rule }
  computed_network_card_list = var.network_card_list == null ? null : toset([
    for card in var.network_card_list : merge(card, {
      security_group_id = var.enable_create_sec ? (card.paas_net_card_type == "manage" ? ctcloud_ecx_v2_security_group.security_group[0].security_group_id : ctcloud_ecx_v2_security_group.business_security_group[0].security_group_id) : card.security_group_id
    })
  ])


}

# 创建安全组
resource "ctcloud_ecx_v2_security_group" "security_group" {
  count       = var.enable_create_sec ? 1 : 0
  account_id  = var.account_id
  region_id   = var.region_id
  name        = var.security_group_name
  description = var.security_group_desc
}

# 创建安全组
resource "ctcloud_ecx_v2_security_group" "business_security_group" {
  count       = var.enable_create_sec ? 1 : 0
  account_id  = var.business_account_id
  is_ops      = var.is_ops
  region_id   = var.region_id
  name        = var.business_security_group_name
  description = var.business_security_group_desc
}

# 创建安全组规则
resource "ctcloud_ecx_v2_security_group_rule" "security_group_rules" {
  depends_on        = [ctcloud_ecx_v2_security_group.security_group]
  for_each          = local.security_rule_map
  account_id        = var.account_id
  region_id         = var.region_id
  security_group_id = ctcloud_ecx_v2_security_group.security_group[0].security_group_id
  direction         = each.value.direction
  description       = each.value.description
  ether_type        = each.value.ether_type
  protocol          = each.value.protocol
  multi_port        = each.value.range
  dest_cidr_ip      = each.value.dest_cidr_ip
  action            = each.value.action
  priority          = each.value.priority
}

resource "ctcloud_ecx_v2_security_group_rule" "business_security_group_rules" {
  depends_on        = [ctcloud_ecx_v2_security_group.business_security_group]
  for_each          = local.business_security_rule_map
  account_id        = var.business_account_id
  is_ops            = var.is_ops
  region_id         = var.region_id
  security_group_id = ctcloud_ecx_v2_security_group.business_security_group[0].security_group_id
  direction         = each.value.direction
  description       = each.value.description
  ether_type        = each.value.ether_type
  protocol          = each.value.protocol
  multi_port        = each.value.range
  dest_cidr_ip      = each.value.dest_cidr_ip
  action            = each.value.action
  priority          = each.value.priority
}

# 创建ecs
resource "ctcloud_ecx_v2_evm" "ecs_fw" {
  count               = var.ecs_create ? 1:0
  account_id          = var.account_id
  region_id           = var.region_id
  image_id            = var.image_id
  flavor_id           = var.flavor_id
  display_name        = var.display_name
  user_password       = var.user_password
  network_card_list   = local.computed_network_card_list
  boot_disk_volume_type = var.boot_disk_volume_type
  boot_disk_type      = var.boot_disk_type
  boot_disk_size      = var.boot_disk_size
  login_type          = var.login_type
  specialized_type    = var.specialized_type
  vpc_id              = var.vpc_id
  charge_type         = var.charge_type
  stop_type           = var.stop_type
}

# resource "ctcloud_ecx_v2_evm_state" "ecx_v2_evm_state" {
#   count = var.enable_ecs_operation ? 1 : 0
#   action = var.action
#   instance_id = var.instance_id
# }

data "ctcloud_ecx_evm_vnc" "ecx_evm_vnc" {
  count = var.enable_ecs_vnc ? 1 : 0
  account_id = var.account_id
  instance_id = var.instance_id
  region_id = var.region_id
}
