# Input Variables

## Resource tags
variable "name" {
  type        = "string"
  description = "Identifier for this stack. This value is used to create the 'Name' resource tag for resources created by this stack item, and also serves as a unique key for re-use."
}

## VPC parameters
variable "vpc_id" {
  type        = "string"
  description = "ID of the target VPC."
}

variable "region" {
  type        = "string"
  description = "AWS region to be utilized."
}

variable "prov" {
  type = "string"
  default = "aws"
  description = "AWS provider to be utilized."
}

variable "subnets" {
  type        = "string"
  description = "List of VPC subnets to associate with the auto scaling group."
}

## LC parameters
variable "ami" {
  type        = "string"
  description = "Amazon Machine Image (AMI) to associate with the launch configuration."
}

variable "instance_type" {
  type        = "string"
  description = "EC2 instance type to associate with the launch configuration."
}

variable "key_name" {
  type        = "string"
  description = "SSH key pair to associate with the launch configuration."
}

variable "associate_public_ip_address" {
  type        = "string"
  description = "Flag for associating public IP addresses with instances managed by the auto scaling group."
  default     = false
}

variable "user_data" {
  type        = "string"
  description = "Instance initialization data to associate with the launch configuration."
}

variable "enable_monitoring" {
  type        = "string"
  description = "Flag to enable detailed monitoring."
  default     = true
}

variable "ebs_optimized" {
  type        = "string"
  description = "Flag to enable EBS optimization."
  default     = false
}

variable "placement_tenancy" {
  type        = "string"
  description = "The tenancy of the instance. Valid values are 'default' or 'dedicated'."
  default     = "default"
}

variable "root_vol_type" {
  type        = "string"
  description = "The type of volume. Valid values are 'standard' or 'gp2'."
  default     = "gp2"
}

variable "root_vol_size" {
  type        = "string"
  description = "The Size of the root volume"
  default     = "12"
}

variable "root_vol_del_on_term" {
  type        = "string"
  description = "Whether the volume should be destroyed on instance termination."
  default     = false
}

variable "data_ebs_vol_type" {
  type        = "string"
  description = "The type of volume. Valid values are 'standard' or 'gp2'."
  default     = "gp2"
}

variable "data_ebs_vol_size" {
  type        = "string"
  description = "The Size of the ebs volume"
  default     = "12"
}

variable "data_ebs_device_name" {
  type        = "string"
  description = "The name of the device to mount."
  default     = "/dev/sdf"
}

variable "data_ebs_snapshot_id" {
  type        = "string"
  description = "The Snapshot ID to mount."
  default     = ""
}

variable "data_ebs_vol_del_on_term" {
  type        = "string"
  description = "Whether the volume should be destroyed on instance termination."
  default     = false
}

variable "logs_ebs_vol_type" {
  type        = "string"
  description = "The type of volume. Valid values are 'standard' or 'gp2'."
  default     = "gp2"
}

variable "logs_ebs_vol_size" {
  type        = "string"
  description = "The Size of the ebs volume"
  default     = "12"
}

variable "logs_ebs_device_name" {
  type        = "string"
  description = "The name of the device to mount."
  default     = "/dev/sdg"
}

variable "logs_ebs_snapshot_id" {
  type        = "string"
  description = "The Snapshot ID to mount."
  default     = ""
}

variable "logs_ebs_vol_del_on_term" {
  type        = "string"
  description = "Whether the volume should be destroyed on instance termination."
  default     = false
}

variable "iam_assume_role_policy" {
  type = "string"
  description = "Assume role policy for IAM role"
}

variable "iam_role_policy" {
  type = "string"
  description = "AWS IAM role policy"
}

## ASG parameters
variable "max_size" {
  type        = "string"
  description = "Maximum number of instances allowed by the auto scaling group."
}

variable "min_size" {
  type        = "string"
  description = "Minimum number of instance to be maintained by the auto scaling group."
}

variable "hc_grace_period" {
  type        = "string"
  description = "Time allowed after an instance comes into service before checking health."
  default     = "300"
}

variable "hc_check_type" {
  type        = "string"
  description = "Type of health check performed by the auto scaling group. Valid values are 'ELB' or 'EC2'."
  default     = "ELB"
}

variable "force_delete" {
  type        = "string"
  description = "Flag to allow deletion of the auto scaling group without waiting for all instances in the pool to terminate."
  default     = false
}

variable "wait_for_capacity_timeout" {
  type        = "string"
  description = "A maximum duration that Terraform should wait for ASG managed instances to become healthy before timing out."
  default     = "10m"
}

variable "load_balancers" {
  type        = "string"
  description = "List of load balancer names to associate with the auto scaling group."
  default     = ""
}

variable "min_elb_capacity" {
  type        = "string"
  description = "Minimum number of healthy instances attached to the ELB that must be maintained during updates."
  default     = ""
}
