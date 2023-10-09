data "aws_iam_policy_document" "unity_catalog_trusted_policy" {
  statement {
    effect  = "Allow"
    actions = ["sts:AssumeRole"]
    principals {
      identifiers = ["arn:aws:iam::414351767826:role/unity-catalog-prod-UCMasterRole-14S5ZJVKOTYTL"]
      type        = "AWS"
    }
    condition {
      test     = "StringEquals"
      variable = "sts:ExternalId"
      values   = [var.databricks_account_id]
    }
  }
  statement {
    sid     = "ExplicitSelfRoleAssumption"
    effect  = "Allow"
    actions = ["sts:AssumeRole"]
    principals {
      type        = "AWS"
      identifiers = ["arn:aws:iam::${var.aws_account_id}:root"]
    }
    condition {
      test     = "ArnLike"
      variable = "aws:PrincipalArn"
      values   = ["arn:aws:iam::${var.aws_account_id}:role/${var.metastore_name}-unity-catalog-role"]
    }
    condition {
      test     = "StringEquals"
      variable = "sts:ExternalId"
      values   = [var.databricks_account_id]
    }
  }
}

// Unity Catalog Role
resource "aws_iam_role" "unity_catalog_role" {
  name               = "${var.metastore_name}-uc-role"
  assume_role_policy = data.aws_iam_policy_document.unity_catalog_trusted_policy.json
  tags = {
    Name = "${var.metastore_name}-uc-role"
  }
}

// Unity Catalog IAM Policy
data "aws_iam_policy_document" "unity_catalog_iam_policy" {
  statement {
    actions = [
      "s3:GetObject",
      "s3:GetObjectVersion",
      "s3:PutObject",
      "s3:PutObjectAcl",
      "s3:DeleteObject",
      "s3:ListBucket",
      "s3:GetBucketLocation"
    ]

    resources = [
      "arn:aws:s3:::${var.bucket}/*",
      "arn:aws:s3:::${var.bucket}"
    ]

    effect = "Allow"
  }

  statement {
    actions   = ["sts:AssumeRole"]
    resources = ["arn:aws:iam::${var.aws_account_id}:role/${var.metastore_name}-uc-role"]
    effect    = "Allow"
  }
}

// Unity Catalog Policy
resource "aws_iam_role_policy" "unity_catalog" {
  name   = "${var.metastore_name}-uc-policy"
  role   = aws_iam_role.unity_catalog_role.id
  policy = data.aws_iam_policy_document.unity_catalog_iam_policy.json
}

