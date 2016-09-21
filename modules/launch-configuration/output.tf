output "security_group_id" {
  value = "${aws_security_group.sg_asg.id}"
}

output "launch_configuration_id" {
  value = "${coalesce(join(",",aws_launch_configuration.lc.*.id),join(",",aws_launch_configuration.lc_ebs.*.id))}"
}
