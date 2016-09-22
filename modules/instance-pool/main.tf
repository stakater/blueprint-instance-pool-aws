# AWS Auto Scaling Configuration

## Creates launch configuration & security group
module "launch-configuration" {
  source = "./launch-configuration"
  ### Resource labels
  name    = "${var.name}-lc"

  ### VPC parameters
  vpc_id = "${var.vpc_id}"
  vpc_cidr = "${var.vpc_cidr}"

  ## LC parameters
  ami                         = "${var.ami}"
  instance_type               = "${var.instance_type}"
  key_name                    = "${var.key_name}"
  iam_assume_role_policy      = "${var.iam_assume_role_policy}"
  iam_role_policy             = "${var.iam_role_policy}"
  associate_public_ip_address = "${var.associate_public_ip_address}"
  user_data                   = "${var.user_data}"
  enable_monitoring           = "${var.enable_monitoring}"
  ebs_optimized               = "${var.ebs_optimized}"
  placement_tenancy           = "${var.placement_tenancy}"
  root_vol_type               = "${var.root_vol_type}"
  root_vol_size               = "${var.root_vol_size}"
  root_vol_del_on_term        = "${var.root_vol_del_on_term}"
  ebs_vol_type                = "${var.ebs_vol_type}"
  ebs_vol_size                = "${var.ebs_vol_size}"
  ebs_device_name             = "${var.ebs_device_name}"
  ebs_snapshot_id             = "${var.ebs_snapshot_id}"
  ebs_vol_del_on_term         = "${var.ebs_vol_del_on_term}"
}

## Creates auto scaling group
module "auto-scaling-group" {
  source = "./auto-scaling-group"

  ### Resource tags
  name    = "${var.name}-asg"

  ### VPC parameters
  subnets = "${var.subnets}"

  ### LC parameters
  lc_id = "${module.launch-configuration.launch_configuration_id}"

  ### ASG parameters
  max_size                  = "${var.max_size}"
  min_size                  = "${var.min_size}"
  hc_grace_period           = "${var.hc_grace_period}"
  hc_check_type             = "${var.hc_check_type}"
  force_delete              = "${var.force_delete}"
  wait_for_capacity_timeout = "${var.wait_for_capacity_timeout}"
  load_balancers            = "${var.load_balancers}"
  min_elb_capacity          = "${var.min_elb_capacity}"
}
