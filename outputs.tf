output "security_group" {
  value       = ctcloud_ecx_v2_security_group.security_group
  description = "输出管理安全组"
}

output "business_security_group" {
  value       = ctcloud_ecx_v2_security_group.business_security_group
  description = "输出业务安全组"
}

output "security_group_rules" {
  value       = values(ctcloud_ecx_v2_security_group_rule.security_group_rules)
  description = "管理安全组规则"
}

output "business_security_group_rules" {
  value       = values(ctcloud_ecx_v2_security_group_rule.business_security_group_rules)
  description = "业务安全组规则"
}

output "ecs_fw" {
  value       = ctcloud_ecx_v2_evm.ecs_fw
  sensitive   = true
  description = "云主机信息"
}

output "ecx_v2_evm_vnc" {
  value       = data.ctcloud_ecx_evm_vnc.ecx_evm_vnc
  sensitive   = true
  description = "云主机vnc信息"
}

