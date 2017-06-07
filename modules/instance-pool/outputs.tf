# Outputs

output "security_group_id" {
  value = "${module.launch-configuration.security_group_id}"
}

output "launch_configuration_id" {
  value = "${module.launch-configuration.launch_configuration_id}"
}

output "asg_id" {
  value = "${module.auto-scaling-group.asg_id}"
}

output "asg_name" {
  value = "${module.auto-scaling-group.asg_name}"
}

#TEST
output "test-output-asg" {
  value = "${module.auto-scaling-group.test-output-asg}"
}
output "test-output-asg-elb" {
  value = "${module.auto-scaling-group.test-output-asg-elb}"
}
