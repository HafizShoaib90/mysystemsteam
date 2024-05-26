
provider "aws" {
  region = "us-east-1"  
}

provider "aws" {
  region = "us-east-2"
  alias= "ohio"  
}

resource "aws_vpc" "mainvpc_e1" {

    cidr_block = "10.0.0.0/16"
}

resource "aws_subnet" "prod_e1" {
    vpc_id = aws_vpc.mainvpc.id
    cidr_block= "10.0.1.0/24" 
}

resource "aws_subnet" "dev_e1" {
    vpc_id = aws_vpc.mainvpc.id
    cidr_block= "10.0.2.0/24" 
}


resource "aws_vpc" "mainvpc_e2" {

    cidr_block = "10.0.0.0/16"
    provider = "aws.ohio"
}

resource "aws_subnet" "prod_e2" {
    vpc_id = aws_vpc.mainvpc.id
    cidr_block= "10.0.1.0/24"
    provider = "aws.ohio" 
}

resource "aws_subnet" "dev_e2" {
    vpc_id = aws_vpc.mainvpc.id
    cidr_block= "10.0.2.0/24"
    provider = "aws.ohio" 
}


