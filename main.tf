provider "aws" {
  
region = "us-east-1"

}


resource "aws_vpc" "myvpc" {
  cidr_block = "192.168.0.0/16"
}
s

resource "aws_subnet" "main" {
  vpc_id     = "${aws_vpc.myvpc.id}"
  cidr_block = "192.168.1.0/24"

  tags = {
    Name = "Main"
  }
}
