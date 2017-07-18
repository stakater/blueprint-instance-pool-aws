output "security_group_id" {
  value = "${aws_security_group.security_group.id}"
}

output "launch_configuration_id" {
  value = "${coalesce(join(",",aws_launch_configuration.lc.*.id),join(",",aws_launch_configuration.lc_ebs_data.*.id),join(",",aws_launch_configuration.lc_ebs_data_logs.*.id),)}"
}
