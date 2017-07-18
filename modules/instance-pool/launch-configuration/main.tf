resource "aws_security_group" "security_group" {
  name_prefix = "${var.name}-sg-"
  description = "${var.name} security group"
  vpc_id      = "${var.vpc_id}"

  tags {
    Name       = "${var.name}-sg"
    managed_by = "stakater"
  }

  lifecycle {
    create_before_destroy = true
  }
}

## Creates launch configuration

##################################################################################################################
# 3 Options:
#
# 1. Launch configuration with no ebs: Don't specify data_ebs_device_name,
#    and other data_ebs variables (logs_ebs values will be ignored in this case)
# 2. Launch configuration with 1 (data) ebs: Specify data_ebs_device_name and other data_ebs variables,
#    don't specify logs_ebs_device_name and other log_ebs values.
# 3. Launch configuration with 2 (data and logs) ebs: Specify data_ebs_device_name and other data_ebs variables,
#    and also specify logs_ebs_device_name and other logs_ebs variables.
###################################################################################################################
resource "aws_launch_configuration" "lc" {
  # if ebs device name is not given or is empty,
  # this count will be 1 resulting in the creation of this resource
  count = "${(signum(length(var.data_ebs_device_name)) + 1) % 2}"

  name_prefix                 = "${var.name}-"
  image_id                    = "${var.ami}"
  instance_type               = "${var.instance_type}"
  iam_instance_profile        = "${aws_iam_instance_profile.lc_instance_profile.name}"
  key_name                    = "${var.key_name}"
  security_groups             = ["${aws_security_group.security_group.id}"]
  associate_public_ip_address = "${var.associate_public_ip_address}"
  user_data                   = "${var.user_data}"
  enable_monitoring           = "${var.enable_monitoring}"
  ebs_optimized               = "${var.ebs_optimized}"
  placement_tenancy           = "${var.placement_tenancy}"

  root_block_device {
    volume_type           = "${var.root_vol_type}"
    delete_on_termination = "${var.root_vol_del_on_term}"
    volume_size           = "${var.root_vol_size}"
  }

  lifecycle {
    create_before_destroy = true
  }
}

resource "aws_launch_configuration" "lc_ebs_data" {
  # if ebs device name is not empty, this count will be 1
  # resulting in the creation of this resource
  count = "${signum(length(var.data_ebs_device_name)) * ((signum(length(var.logs_ebs_device_name)) + 1) % 2)}"

  name_prefix                 = "${var.name}-"
  image_id                    = "${var.ami}"
  instance_type               = "${var.instance_type}"
  iam_instance_profile        = "${aws_iam_instance_profile.lc_instance_profile.name}"
  key_name                    = "${var.key_name}"
  security_groups             = ["${aws_security_group.security_group.id}"]
  associate_public_ip_address = "${var.associate_public_ip_address}"
  user_data                   = "${var.user_data}"
  enable_monitoring           = "${var.enable_monitoring}"
  ebs_optimized               = "${var.ebs_optimized}"
  placement_tenancy           = "${var.placement_tenancy}"

  root_block_device {
    volume_type           = "${var.root_vol_type}"
    delete_on_termination = "${var.root_vol_del_on_term}"
    volume_size           = "${var.root_vol_size}"
  }

  # EBS Volume for Data
  ebs_block_device {
    volume_type           = "${var.data_ebs_vol_type}"
    volume_size           = "${var.data_ebs_vol_size}"
    device_name           = "${var.data_ebs_device_name}"
    snapshot_id           = "${var.data_ebs_snapshot_id}"
    delete_on_termination = "${var.data_ebs_vol_del_on_term}"
  }

  lifecycle {
    create_before_destroy = true
  }
}

resource "aws_launch_configuration" "lc_ebs_data_logs" {
  # if ebs device name is not empty, this count will be 1
  # resulting in the creation of this resource
  count = "${signum(length(var.data_ebs_device_name)) * signum(length(var.logs_ebs_device_name))}"

  name_prefix                 = "${var.name}-"
  image_id                    = "${var.ami}"
  instance_type               = "${var.instance_type}"
  iam_instance_profile        = "${aws_iam_instance_profile.lc_instance_profile.name}"
  key_name                    = "${var.key_name}"
  security_groups             = ["${aws_security_group.security_group.id}"]
  associate_public_ip_address = "${var.associate_public_ip_address}"
  user_data                   = "${var.user_data}"
  enable_monitoring           = "${var.enable_monitoring}"
  ebs_optimized               = "${var.ebs_optimized}"
  placement_tenancy           = "${var.placement_tenancy}"

  root_block_device {
    volume_type           = "${var.root_vol_type}"
    delete_on_termination = "${var.root_vol_del_on_term}"
    volume_size           = "${var.root_vol_size}"
  }

  # EBS Volume for Data
  ebs_block_device {
    volume_type           = "${var.data_ebs_vol_type}"
    volume_size           = "${var.data_ebs_vol_size}"
    device_name           = "${var.data_ebs_device_name}"
    snapshot_id           = "${var.data_ebs_snapshot_id}"
    delete_on_termination = "${var.data_ebs_vol_del_on_term}"
  }

  # EBS Volume for Logs
  ebs_block_device {
    volume_type           = "${var.logs_ebs_vol_type}"
    volume_size           = "${var.logs_ebs_vol_size}"
    device_name           = "${var.logs_ebs_device_name}"
    snapshot_id           = "${var.logs_ebs_snapshot_id}"
    delete_on_termination = "${var.logs_ebs_vol_del_on_term}"
  }

  lifecycle {
    create_before_destroy = true
  }
}
