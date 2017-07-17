# AWS Auto Scaling Configuration

## Creates launch configuration & security group
module "launch-configuration" {
  source = "./launch-configuration"

  ### Resource labels
  name = "${var.name}-lc"

  ### VPC parameters
  vpc_id = "${var.vpc_id}"

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

  # Root Volume
  root_vol_type        = "${var.root_vol_type}"
  root_vol_size        = "${var.root_vol_size}"
  root_vol_del_on_term = "${var.root_vol_del_on_term}"

  # Data EBS Volume
  data_ebs_vol_type        = "${var.data_ebs_vol_type}"
  data_ebs_vol_size        = "${var.data_ebs_vol_size}"
  data_ebs_device_name     = "${var.data_ebs_device_name}"
  data_ebs_snapshot_id     = "${var.data_ebs_snapshot_id}"
  data_ebs_vol_del_on_term = "${var.data_ebs_vol_del_on_term}"

  # Logs EBS Volume
  logs_ebs_vol_type        = "${var.logs_ebs_vol_type}"
  logs_ebs_vol_size        = "${var.logs_ebs_vol_size}"
  logs_ebs_device_name     = "${var.logs_ebs_device_name}"
  logs_ebs_snapshot_id     = "${var.logs_ebs_snapshot_id}"
  logs_ebs_vol_del_on_term = "${var.logs_ebs_vol_del_on_term}"
}

## Creates auto scaling group
module "auto-scaling-group" {
  source = "./auto-scaling-group"

  ### Resource tags
  name = "${var.name}"

  ### VPC parameters
  subnets = "${var.subnets}"

  ### LC parameters
  lc_id = "${module.launch-configuration.launch_configuration_id}"

  ### ASG parameters
  max_size                  = "${var.max_size}"
  min_size                  = "${var.min_size}"
  desired_capacity          = "${var.desired_size}"
  hc_grace_period           = "${var.hc_grace_period}"
  hc_check_type             = "${var.hc_check_type}"
  force_delete              = "${var.force_delete}"
  wait_for_capacity_timeout = "${var.wait_for_capacity_timeout}"
  load_balancers            = "${var.load_balancers}"
  min_elb_capacity          = "${var.min_elb_capacity}"
}
