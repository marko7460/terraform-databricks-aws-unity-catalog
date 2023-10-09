resource "null_resource" "previous" {}

resource "time_sleep" "wait_30_seconds" {
  depends_on = [null_resource.previous]

  create_duration = "30s"
}

// Unity Catalog S3
resource "aws_s3_bucket" "unity_catalog_bucket" {
  count         = var.create_bucket ? 1 : 0
  bucket        = var.bucket
  force_destroy = true
  tags = {
    Name = var.bucket
  }
}

resource "aws_s3_bucket_versioning" "unity_catalog_versioning" {
  count  = var.create_bucket ? 1 : 0
  bucket = aws_s3_bucket.unity_catalog_bucket[0].id
  versioning_configuration {
    status = "Disabled"
  }
}

resource "aws_s3_bucket_server_side_encryption_configuration" "unity_catalog" {
  count  = var.create_bucket ? 1 : 0
  bucket = aws_s3_bucket.unity_catalog_bucket[0].bucket

  rule {
    apply_server_side_encryption_by_default {
      sse_algorithm = "AES256"
    }
  }
}

resource "aws_s3_bucket_public_access_block" "unity_catalog" {
  count = var.create_bucket ? 1 : 0

  bucket                  = aws_s3_bucket.unity_catalog_bucket[0].id
  block_public_acls       = true
  block_public_policy     = true
  ignore_public_acls      = true
  restrict_public_buckets = true
  depends_on              = [aws_s3_bucket.unity_catalog_bucket]
}

resource "databricks_metastore" "this" {
  name          = var.metastore_name
  region        = var.region
  storage_root  = "s3://${var.bucket}/${var.prefix}"
  force_destroy = true
}

// Metastore Data Access
resource "databricks_metastore_data_access" "this" {
  metastore_id = databricks_metastore.this.id
  name         = aws_iam_role.unity_catalog_role.name
  aws_iam_role {
    role_arn = aws_iam_role.unity_catalog_role.arn
  }
  is_default = true
  depends_on = [
    databricks_metastore.this, aws_iam_role.unity_catalog_role, time_sleep.wait_30_seconds
  ]
}
