resource "aws_security_group" "security_group" {
  name_prefix = "${var.name}-sg-"
  description = "${var.name} security group"
  vpc_id      = "${var.vpc_id}"

  tags {
    Name        = "${var.name}-sg"
    managed_by  = "stakater"
  }

  lifecycle {
    create_before_destroy = true
  }
}

## Creates launch configuration
resource "aws_launch_configuration" "lc" {
  # if ebs device name is not given or is empty,
  # this count will be 1 resulting in the creation of this resource
  count                       = "${signum(length(var.ebs_device_name)) + 1 % 2}"
  name_prefix                 = "${var.name}-"
  image_id                    = "${var.ami}"
  instance_type               = "${var.instance_type}"
  iam_instance_profile        = "${var.instance_profile}"
  key_name                    = "${var.key_name}"
  security_groups             = ["${aws_security_group.sg_asg.id}"]
  associate_public_ip_address = "${var.associate_public_ip_address}"
  user_data                   = "${var.user_data}"
  enable_monitoring           = "${var.enable_monitoring}"
  ebs_optimized               = "${var.ebs_optimized}"
  placement_tenancy           = "${var.placement_tenancy}"

  root_block_device {
    volume_type           = "${var.root_vol_type}"
    delete_on_termination = "${var.root_vol_del_on_term}"
  }

  lifecycle {
    create_before_destroy = true
  }
}

resource "aws_launch_configuration" "lc_ebs" {
  # if ebs device name is not empty, this count will be 1
  # resulting in the creation of this resource
  count                       = "${signum(length(var.ebs_device_name))}"
  name_prefix                 = "${var.name}-"
  image_id                    = "${var.ami}"
  instance_type               = "${var.instance_type}"
  iam_instance_profile        = "${var.instance_profile}"
  key_name                    = "${var.key_name}"
  security_groups             = ["${aws_security_group.sg_asg.id}"]
  associate_public_ip_address = "${var.associate_public_ip_address}"
  user_data                   = "${var.user_data}"
  enable_monitoring           = "${var.enable_monitoring}"
  ebs_optimized               = "${var.ebs_optimized}"
  placement_tenancy           = "${var.placement_tenancy}"

  root_block_device {
    volume_type           = "${var.root_vol_type}"
    delete_on_termination = "${var.root_vol_del_on_term}"
  }

  ebs_block_device {
    volume_type           = "${var.ebs_vol_type}"
    device_name           = "${var.ebs_device_name}"
    delete_on_termination = "${var.ebs_vol_del_on_term}"
  }

  lifecycle {
    create_before_destroy = true
  }
}