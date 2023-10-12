resource "null_resource" "previous" {}

resource "time_sleep" "wait_30_seconds" {
  depends_on = [null_resource.previous]

  create_duration = "30s"
}

resource "aws_s3_bucket" "external" {
  count  = var.create_bucket ? 1 : 0
  bucket = var.bucket
  // destroy all objects with bucket destroy
  force_destroy = true
}

resource "aws_s3_bucket_versioning" "external_versioning" {
  count  = var.create_bucket ? 1 : 0
  bucket = aws_s3_bucket.external.id
  versioning_configuration {
    status = "Disabled"
  }
}

resource "aws_s3_bucket_public_access_block" "external" {
  count              = var.create_bucket ? 1 : 0
  bucket             = aws_s3_bucket.external.id
  ignore_public_acls = true
  depends_on         = [aws_s3_bucket.external]
}

// Storage Credential Trust Policy
data "aws_iam_policy_document" "passrole_for_storage_credential" {
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
      values   = ["arn:aws:iam::${var.aws_account_id}:role/${var.bucket}-uc-storage-credential"]
    }
    condition {
      test     = "StringEquals"
      variable = "sts:ExternalId"
      values   = [var.databricks_account_id]
    }
  }
}

// Storage Credential Role
resource "aws_iam_role" "storage_credential_role" {
  name               = "${var.bucket}-uc-storage-credential"
  assume_role_policy = data.aws_iam_policy_document.passrole_for_storage_credential.json
  tags = {
    Name = "${var.bucket}-storage_credential_role"
  }
}


// Storage Credential Policy
resource "aws_iam_role_policy" "storage_credential_policy" {
  name = "${var.bucket}-uc-storage-credential-policy"
  role = aws_iam_role.storage_credential_role.id
  policy = jsonencode({ Version : "2012-10-17",
    Statement : [
      {
        "Action" : [
          "s3:GetObject",
          "s3:ListBucket",
          "s3:GetBucketLocation",
          "s3:GetLifecycleConfiguration",
        ],
        "Resource" : [
          "arn:aws:s3:::${var.bucket}/*",
          "arn:aws:s3:::${var.bucket}"
        ],
        "Effect" : "Allow"
      },
      {
        "Action" : [
          "sts:AssumeRole"
        ],
        "Resource" : [
          "arn:aws:iam::${var.aws_account_id}:role/${var.bucket}-uc-storage-credential"
        ],
        "Effect" : "Allow"
      }
    ]
    }
  )
}

// Storage Credential
resource "databricks_storage_credential" "external" {
  name = aws_iam_role.storage_credential_role.name
  aws_iam_role {
    role_arn = aws_iam_role.storage_credential_role.arn
  }
  depends_on = [aws_iam_role.storage_credential_role, time_sleep.wait_30_seconds]
}

// External Location
resource "databricks_external_location" "data_example" {
  name            = var.bucket
  url             = "s3://${var.bucket}/${var.prefix}"
  credential_name = databricks_storage_credential.external.id
  skip_validation = var.skip_validation
  read_only       = var.read_only
  force_destroy   = var.force_destroy
  owner           = var.owner
  comment         = "Managed by TF"
}

resource "databricks_grants" "external_location_grants" {
  count             = length(var.external_location_grants) > 0 ? 1 : 0
  external_location = databricks_external_location.data_example.id
  dynamic "grant" {
    for_each = { for g in var.external_location_grants : g.principal => g }
    content {
      principal  = grant.value.principal
      privileges = grant.value.privileges
    }
  }
}

resource "databricks_grants" "external_creds_grants" {
  count              = length(var.external_creds_grants) > 0 ? 1 : 0
  storage_credential = databricks_storage_credential.external.id
  dynamic "grant" {
    for_each = { for g in var.external_creds_grants : g.principal => g }
    content {
      principal  = grant.value.principal
      privileges = grant.value.privileges
    }
  }
}