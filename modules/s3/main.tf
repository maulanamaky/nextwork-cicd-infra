resource "aws_s3_bucket" "nextwork_bucket" {
  bucket = var.bucket
  force_destroy = true
}

resource "aws_s3_bucket_public_access_block" "nextwork_bucket_access" {
  bucket = aws_s3_bucket.nextwork_bucket.id

  block_public_acls       = var.block_public_acls
  block_public_policy     = var.block_public_policy
  ignore_public_acls      = var.ignore_public_acls
  restrict_public_buckets = var.restrict_public_buckets
}

resource "aws_s3_bucket_versioning" "nextwork_bucket_versioning" {
  bucket = aws_s3_bucket.nextwork_bucket.id
  versioning_configuration {
    status = var.versioning_status
  }
}

resource "aws_s3_bucket_server_side_encryption_configuration" "nextwork_bucket_encryption" {
  bucket = aws_s3_bucket.nextwork_bucket.id

  rule {
    apply_server_side_encryption_by_default {
      sse_algorithm     = "AES256"
    }
  }
}