provider "aws" {
  region = "us-east-1"
}

resource "aws_vpc" "mainvpc_e1" {
  cidr_block       = "192.168.0.0/16"
}

resource "aws_subnet" "main" {
vpc_id     = aws_vpc.mainvpc_e1.id
cidr_block = "192.168.1.0/24"
}