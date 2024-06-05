provider "aws" {
  region = "us-west-1" 
 }


data "aws_vpc" "console" {
  id = "vpc-0891787f1094b6039"
}

resource "aws_subnet" "mysubnet" {
vpc_id= data.aws_vpc.console.id  
cidr_block = "192.168.1.0/24"
}


resource "aws_security_group" "allow_all" {
  name        = "allow_all"
  vpc_id      = data.aws_vpc.console.id

  ingress {
    description = "Internet from VPC"
    from_port   = 0
    to_port     = 0
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }

  tags = {
    Name = "all allow"
  }
}


resource "aws_instance" "windows_instance" {
  ami           = "ami-0e6552a39ee0995d6" 
  instance_type = "t2.micro"              
  key_name      = "testkp"            
  subnet_id     = aws_subnet.mysubnet.id      
  vpc_security_group_ids = [aws_security_group.allow_all.id] 
 

tags = {
    Name = "AWS-test-SVR"
    Env = "Prod"
}
 
}