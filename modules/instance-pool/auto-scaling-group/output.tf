# Outputs

output "asg_id" {
  value = "${coalesce(join(",",aws_autoscaling_group.asg.*.id),join(",",aws_autoscaling_group.asg_elb.*.id))}"
}

output "asg_name" {
  value = "${coalesce(join(",",aws_autoscaling_group.asg.*.name),join(",",aws_autoscaling_group.asg_elb.*.name))}"
}


output "policy_arn" {
  value = "${coalesce(join(",",aws_autoscaling_policy.asg_policy.*.arn),join(",",aws_autoscaling_policy.asg_policy_percent.*.arn))}"
}

output "sns_arn" {
  value = "${aws_sns_topic.sns_asg.arn}"
}