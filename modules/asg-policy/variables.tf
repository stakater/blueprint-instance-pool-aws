# Input Variables

## Resource tags
variable "name" {
  type        = "string"
  description = "Identifier for this stack. This value is used to create the 'Name' resource tag for resources created by this stack item, and also serves as a unique key for re-use."
}

## ASG parameters
variable "asg_name" {
  type        = "string"
  description = "Name of the ASG to associate the alarm with."
}

## Notification parameters
variable "notifications" {
  type        = "string"
  description = "List of events to associate with the auto scaling notification."
  default     = "autoscaling:EC2_INSTANCE_LAUNCH,autoscaling:EC2_INSTANCE_TERMINATE,autoscaling:EC2_INSTANCE_LAUNCH_ERROR,autoscaling:EC2_INSTANCE_TERMINATE_ERROR"
}

## Policy parameters
variable "adjustment_type" {
  type        = "string"
  description = "Specifies the scaling adjustment.  Valid values are 'ChangeInCapacity', 'ExactCapacity' or 'PercentChangeInCapacity'."
  default = "" # Default value given due to: https://github.com/hashicorp/terraform/issues/8146
}

variable "scaling_adjustment" {
  type        = "string"
  description = "The number of instances involved in a scaling action."
}

variable "cooldown" {
  type        = "string"
  description = "Seconds between auto scaling activities."
}

variable "min_adjustment_magnitude" {
  type        = "string"
  description = "Minimum number of instances to be involved in a scaling adjustment based on percentage of capacity."
  default     = 1
}

## Conditional toggles
variable "selector" {
  type = "map"

  default = {
    ChangeInCapacity        = 1
    ExactCapacity           = 1
    PercentChangeInCapacity = 0
  }
}

## Monitor parameters
variable "comparison_operator" {
  type        = "string"
  description = "Arithmetic operation to use when comparing the thresholds. Valid values are 'GreaterThanOrEqualToThreshold', 'GreaterThanThreshold', 'LessThanThreshold' and 'LessThanOrEqualToThreshold'"
}

variable "evaluation_periods" {
  type        = "string"
  description = "The number of periods over which data is compared to the specified threshold."
}

variable "metric_name" {
  type        = "string"
  description = "Name for the alarm's associated metric."
}

variable "name_space" {
  type        = "string"
  description = "The namespace for the alarm's associated metric."
  default     = "AWS/EC2"
}

variable "period" {
  type        = "string"
  description = "The period in seconds over which the specified statistic is applied."
}

variable "statistic" {
  type        = "string"
  description = "The statistic to apply to the alarm's associated metric. Valid values are 'SampleCount', 'Average', 'Sum', 'Minimum' and 'Maximum'"
  default     = "Average"
}

variable "valid_statistics" {
  type = "map"

  default = {
    Average     = "Average"
    Maximum     = "Maximum"
    Minimum     = "Minimum"
    SampleCount = "SampleCount"
    Sum         = "Sum"
  }
}

variable "threshold" {
  type        = "string"
  description = "The value against which the specified statistic is compared."
}
