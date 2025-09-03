# 🚨 VULNERABLE: Unencrypted EBS volume
resource "aws_ebs_volume" "unencrypted_volume" {
  availability_zone = "us-east-1a"
  size              = 10
  type              = "gp2"
  # missing encryption => should set encrypted = true
}

# 🚨 VULNERABLE: RDS instance with public access and no encryption
resource "aws_db_instance" "insecure_rds" {
  identifier         = "insecure-rds"
  allocated_storage  = 20
  engine             = "mysql"
  engine_version     = "8.0"
  instance_class     = "db.t3.micro"
  username           = "admin"
  password           = "password123"
  publicly_accessible = true  # 🚨 Should be false
  storage_encrypted   = false # 🚨 Should be true
  skip_final_snapshot = true
}
