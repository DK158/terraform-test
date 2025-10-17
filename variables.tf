# 通用部分参数
variable "ak" {
  description = "ak"
  type        = string
  nullable    = false
  default     = ""
}
variable "sk" {
  description = "sk"
  type        = string
  nullable    = false
  default     = ""
}
variable "env" {
  description = "env"
  type        = string
  nullable    = false
  default     = "ecxProd"
}
variable "master_order_id" {
  description = "主订单id "
  type        = string
  nullable    = false
  default     = ""
}
variable "paas_resource_id" {
  type          = string
  description   = "paas_resource_id"
  nullable      = false
  default       = ""
}
variable "account_id" {
  type          = string
  description   = "account_id"
  nullable      = false
  default       = ""
}

variable "user_id" {
  type          = string
  description   = "user_id"
  nullable      = false
  default       = ""
}

variable "business_account_id" {
  type          = string
  description   = "user_account_id"
  nullable      = false
  default       = ""
}

variable "region_id" {
  description = "资源池id"
  type        = string
  nullable    = false
  default     = ""
}
variable "vpc_id" {
  description = "vpc id"
  type        = string
  nullable    = false
  default     = ""
}
variable "subnet_id" {
  description = "subnet id"
  type        = string
  nullable    = false
  default     = ""
}
variable "enable_ipv6" {
  description = "是否需要支持ipv6"
  type        = bool
  nullable    = false
  default     = false
}

variable "is_ops" {
  description = "是否是ops操作"
  type        = bool
  nullable    = true
  default     = true
}

## 安全组变量
variable "enable_create_sec" {
  description = "是否创建安全组"
  type        = bool
  nullable    = false
  default     = true
}

variable "security_group_id" {
  description = "安全组id"
  type        = string
  nullable    = true
  default     = null
}

variable "security_group_name" {
  description = "管理网卡安全组名称"
  type        = string
  nullable    = true
  default     = null
}
variable "security_group_desc" {
  description = "管理网卡安全组描述"
  type        = string
  default     = "防火墙管理安全组"
  nullable    = true
}
variable "business_security_group_name" {
  description = "业务网卡安全组名称"
  type        = string
  nullable    = true
  default     = null
}
variable "business_security_group_desc" {
  description = "业务网卡安全组描述"
  type        = string
  default     = "防火墙业务安全组"
  nullable    = true
}
## 安全组规则
variable "security_rules" {
  description     = "安全组规则"
  type            = set(object({
    direction     = string
    action        = string
    priority      = optional(number, 1)
    protocol      = optional(string, "TCP")
    ether_type    = optional(string, "IPv4")
    dest_cidr_ip  = string
    description   = optional(string, "管理网卡安全组规则")
    range         = optional(string, "10443")
  }))
  default     = null
  nullable    = true
}

variable "business_security_rules" {
  description     = "业务网卡安全组规则"
  type            = set(object({
    direction     = string
    action        = string
    priority      = optional(number, 1)
    protocol      = optional(string, "TCP")
    ether_type    = optional(string, "IPv4")
    dest_cidr_ip  = string
    description   = optional(string, "业务网卡安全组规则")
    range         = optional(string, "ALL")
  }))
  default     = null
  nullable    = true
}

## 防火墙引擎机器
variable "ecs_create" {
  description = "是否创建"
  type        = bool
  nullable    = false
  default     = true
}


variable "image_id" {
  description = "镜像ID"
  type        = string
  nullable    = false
}
variable "flavor_id" {
  description = "规格ID"
  type        = string
  nullable    = true
  default     = null
}
variable "display_name" {
  description = "主机名称"
  type        = string
  nullable    = true
  default     = null
}
variable "user_password" {
  description = "登陆密码"
  type        = string
  nullable    = true
  default     = null
}
variable "boot_disk_volume_type" {
  description = "系统盘类型"
  type        = string
  nullable    = true
  default     = "cloud"
}
variable "boot_disk_size" {
  description = "系统盘大小"
  type        = string
  nullable    = true
  default     = null
}
variable "boot_disk_type" {
  description = "系统盘IO类型"
  type        = string
  nullable    = true
  default     = null
}
variable "login_type" {
  description = "登录方式"
  type        = string
  nullable    = true
  default     = "password"
}
variable "specialized_type" {
  description = "专用类型"
  type        = string
  nullable    = true
  default     = "paas"
}
variable "charge_type" {
  description = "虚机实例付费方式"
  type        = string
  nullable    = true
  default     = "payForUse"
}
variable "evm_group" {
  description = "需要加入的虚机组 ID"
  type        = string
  nullable    = true
  default     = null
}
variable "custom_data" {
  description = "虚机自定义数据"
  type        = string
  nullable    = true
  default     = null
}
variable "stop_type" {
  description = "关机类型"
  type        = string
  nullable    = true
  default     = "SOFT"
}


variable "network_card_list" {
  description               = "网卡相关配置"
  type                      = set(object({
    subnet_id               = string
    security_group_id       = optional(string, "")
    paas_net_card_type      = optional(string, "manage")
    ctyun_acct_id           = string
    eip_type                = optional(string)
    ip_address              = optional(string)
  }))
  default     = null
  nullable    = true
}


# ecs operation
variable "action" {
  description = "操作类型"
  type        = string
  nullable    = true
  default     = ""
}
variable "instance_id" {
  description = "虚机ID"
  type        = string
  nullable    = true
  default     = ""
}
variable "enable_ecs_operation" {
  description = "是否执行ecs操作，重启、关机等"
  type        = bool
  nullable    = true
  default     = false
}

# ecs vnc
variable "enable_ecs_vnc" {
  description = "是否执行ecs vnc 查询"
  type        = bool
  nullable    = true
  default     = false
}

