output "eip_id" {
  description = "Association ID"
  value       = aws_eip.lb.id
}

# output "tf_module_name" {
#   description = "The terraform module name."
#   value       = local.tf_module_name
# }

# output "tf_module_version" {
#   description = "The terraform module version."
#   value       = local.tf_module_version
# }
