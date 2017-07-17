# AWS Auto Scaling Group

## Creates auto scaling group
resource "aws_autoscaling_group" "asg" {
  # if load balancer id(s) is not given or is empty,
  # this count will be 1 resulting in the creation of this resource
  count = "${length(var.min_elb_capacity) > 0 ? 0 : 1 }"

  name                      = "${var.lc_id}-asg"
  max_size                  = "${var.max_size}"
  min_size                  = "${var.min_size}"
  desired_capacity          = "${var.desired_capacity}"
  launch_configuration      = "${var.lc_id}"
  health_check_grace_period = "${var.hc_grace_period}"
  health_check_type         = "EC2"
  force_delete              = "${var.force_delete}"
  vpc_zone_identifier       = ["${split(",",var.subnets)}"]
  wait_for_capacity_timeout = "${var.wait_for_capacity_timeout}"

  lifecycle {
    create_before_destroy = true
  }

  tag {
    key                 = "Name"
    value               = "${var.name}"
    propagate_at_launch = true
  }
}

resource "aws_autoscaling_group" "asg_elb" {
  # if load balancer id(s) is not empty,
  # this count will be 1 resulting in the creation of this resource
  count = "${length(var.min_elb_capacity) > 0 ? 1 : 0 }"

  name                      = "${var.lc_id}-asg"
  max_size                  = "${var.max_size}"
  min_size                  = "${var.min_size}"
  desired_capacity          = "${var.desired_capacity}"
  launch_configuration      = "${var.lc_id}"
  health_check_grace_period = "${var.hc_grace_period}"
  health_check_type         = "${var.hc_check_type}"
  force_delete              = "${var.force_delete}"
  min_elb_capacity          = "${var.min_elb_capacity}"
  load_balancers            = ["${split(",",var.load_balancers)}"]
  vpc_zone_identifier       = ["${split(",",var.subnets)}"]
  wait_for_capacity_timeout = "${var.wait_for_capacity_timeout}"

  lifecycle {
    create_before_destroy = true
  }

  tag {
    key                 = "Name"
    value               = "${var.name}"
    propagate_at_launch = true
  }
}
