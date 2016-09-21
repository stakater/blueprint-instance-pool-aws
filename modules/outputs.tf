# Outputs

output "security_group_id" {
  value = "${module.lc.security_group_id}"
}

output "launch_configuration_id" {
  value = "${module.lc.launch_configuration_id}"
}

output "asg_id" {
  value = "${module.asg.asg_id}"
}

output "asg_name" {
  value = "${module.asg.asg_name}"
}
