locals {
  env="local"
}

# Create a VPC
resource "aws_s3_bucket" "this" {
  bucket = "mytest-bucket-lpnu"

  tags = {
    Name         = "My bucket"
    Enviroonment = "Dev"
  }
}

resource "aws_s3_bucket" "this2" {
  bucket = "mytest-bucket-lpnu2"

  tags = {
    Name         = "My bucket"
    Enviroonment = local.env
  }
}
