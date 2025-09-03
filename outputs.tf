output "public_bucket" {
  value = aws_s3_bucket.public_bucket.bucket
}

output "secure_bucket" {
  value = aws_s3_bucket.secure_bucket.bucket
}
