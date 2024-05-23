provider "aws" {
  region = "us-east-1"
}

resource "aws_s3_bucket" "myfirstcode" {
  bucket = "hafizshoaib1-test-first-bucket"
}


