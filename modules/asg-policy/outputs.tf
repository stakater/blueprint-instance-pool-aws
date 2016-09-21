# Outputs
output "policy_arn" {
  value = "${coalesce(join(",",aws_autoscaling_policy.asg_policy.*.arn),join(",",aws_autoscaling_policy.asg_policy_percent.*.arn))}"
}

output "sns_arn" {
  value = "${aws_sns_topic.sns_asg.arn}"
}
