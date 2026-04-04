output "bucket_arn" {
    value = aws_s3_bucket.nextwork_bucket.arn
}

output "bucket_name" {
    value = aws_s3_bucket.nextwork_bucket.bucket
}