resource "aws_s3_bucket" "project_tfstate" {
  bucket = "${var.project}-tfstate"
  region = var.region
  acl    = "private"

  versioning {
    enabled = true
  }

  lifecycle {
    prevent_destroy = true
  }

  server_side_encryption_configuration {
    rule {
      apply_server_side_encryption_by_default {
        sse_algorithm = "AES256"
      }
    }
  }

  tags = {
    Name        = "${var.project}-tfstate"
    project     = var.project
    environment = var.environment
  }
}


resource "aws_dynamodb_table" "project_tflock" {
  name           = "${var.project}-tflock"
  hash_key       = "LockID"
  read_capacity  = 5
  write_capacity = 5

  attribute {
    name = "LockID"
    type = "S"
  }

  tags = {
    Name        = "${var.project}-tflock"
    project     = var.project
    environment = var.environment
  }
}