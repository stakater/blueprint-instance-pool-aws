# Auto Scaling Policy
## Creates simple absolute scaling policy
resource "aws_autoscaling_policy" "asg_policy" {
  count                  = "${lookup(var.selector, var.adjustment_type)}"
  name                   = "${var.name}"
  autoscaling_group_name = "${var.asg_name}"
  adjustment_type        = "${var.adjustment_type}"
  scaling_adjustment     = "${var.scaling_adjustment}"
  cooldown               = "${var.cooldown}"
  policy_type            = "SimpleScaling"
}

## Creates simple percentage scaling policy
resource "aws_autoscaling_policy" "asg_policy_percent" {
  count                    = "${lookup(var.selector, var.adjustment_type) + 1 % 2}"
  name                     = "${var.name}"
  autoscaling_group_name   = "${var.asg_name}"
  adjustment_type          = "${var.adjustment_type}"
  scaling_adjustment       = "${var.scaling_adjustment}"
  min_adjustment_magnitude = "${var.min_adjustment_magnitude}"
  cooldown                 = "${var.cooldown}"
  policy_type              = "SimpleScaling"
}

## Creates Simple Notification Service (SNS) topic
resource "aws_sns_topic" "sns_asg" {
  name         = "${var.name}-asg"
  display_name = "${var.name} ASG SNS topic"
}

## Configures autoscaling notifications
resource "aws_autoscaling_notification" "asg_notify" {
  group_names   = ["${var.asg_id}"]
  notifications = ["${split(",",var.notifications)}"]
  topic_arn     = "${aws_sns_topic.sns_asg.arn}"
}

## Creates CloudWatch monitor
resource "aws_cloudwatch_metric_alarm" "monitor_asg" {
  alarm_name          = "${var.name}-asg"
  alarm_description   = "${var.name} ASG Monitor"
  comparison_operator = "${var.comparison_operator}"
  evaluation_periods  = "${var.evaluation_periods}"
  metric_name         = "${var.metric_name}"
  namespace           = "${var.name_space}"
  period              = "${var.period}"
  statistic           = "${lookup(var.valid_statistics, var.statistic)}"
  threshold           = "${var.threshold}"

  dimensions = {
    "AutoScalingGroupName" = "${var.asg_name}"
  }

  actions_enabled = true
  alarm_actions   = ["${coalesce(join(",",aws_autoscaling_policy.asg_policy.*.arn),join(",",aws_autoscaling_policy.asg_policy_percent.*.arn))}"]
}
