provider "aws" {
  region = "us-east-1"
}

# 🚨 VULNERABLE: Public S3 bucket
resource "aws_s3_bucket" "public_bucket" {
  bucket = "my-public-bucket-poc"
  acl    = "public-read" # Should be private
}

# 🚨 VULNERABLE: Security group allows all traffic
resource "aws_security_group" "open_sg" {
  name        = "open_sg"
  description = "Open to the world"
  vpc_id      = "vpc-123456"

  ingress {
    from_port   = 22
    to_port     = 22
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"] # Should be restricted
  }

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }
}

# ✅ SAFE: Encrypted S3 bucket
resource "aws_s3_bucket" "secure_bucket" {
  bucket = "my-secure-bucket-poc"
  acl    = "private"

  server_side_encryption_configuration {
    rule {
      apply_server_side_encryption_by_default {
        sse_algorithm = "AES256"
      }
    }
  }
}
