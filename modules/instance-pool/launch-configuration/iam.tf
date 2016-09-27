## Creates IAM role
resource "aws_iam_role" "lc_role" {
  # Same name for instance profile and role, for ease while fetching data using AWS meta-data API
  name = "${var.name}"
  path = "/"

  lifecycle {
    create_before_destroy = true
  }

  assume_role_policy = "${var.iam_assume_role_policy}"
}

resource "aws_iam_instance_profile" "lc_instance_profile" {
  # Same name for instance profile and role, for ease while fetching data using AWS meta-data API
  name  = "${var.name}"
  roles = ["${aws_iam_role.lc_role.name}"]

  lifecycle {
    create_before_destroy = true
  }
}

resource "aws_iam_role_policy" "lc_role_policy" {
  name = "${var.name}-role-policy"
  role = "${aws_iam_role.lc_role.id}"

  lifecycle {
    create_before_destroy = true
  }

  policy = "${var.iam_role_policy}"
}
