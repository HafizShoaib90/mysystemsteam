provider "aws" {
  region = "us-east-1"
}

resource "aws_s3_bucket" "example1" {
  bucket = "hafizshoaib1-test-first-bucket"
}


