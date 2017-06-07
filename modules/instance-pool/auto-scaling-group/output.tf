# Outputs

output "asg_id" {
  value = "${coalesce(join(",",aws_autoscaling_group.asg.*.id),join(",",aws_autoscaling_group.asg_elb.*.id))}"
}

output "asg_name" {
  value = "${coalesce(join(",",aws_autoscaling_group.asg.*.name),join(",",aws_autoscaling_group.asg_elb.*.name))}"
}

#TEST
output "test-output-asg" {
  value = "${(signum(length(compact(split(",",var.load_balancers)))) + 1) % 2}"
}
output "test-output-asg-elb" {
  value = "${signum(length(compact(split(",",var.load_balancers))))}"
}