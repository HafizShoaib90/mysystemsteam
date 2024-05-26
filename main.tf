
provider "aws" {
  region = "us-east-1"  
}

provider "aws" {
  region = "us-east-2"
  alias= "ohio"  
}

resource "aws_vpc" "mainvpc" {

    cidr_block = "10.0.0.0/16"
}

resource "aws_subnet" "prod" {
    vpc_id = aws_vpc.mainvpc.id
    cidr_block= "10.0.1.0/24" 
}

resource "aws_subnet" "dev" {
    vpc_id = aws_vpc.mainvpc.id
    cidr_block= "10.0.2.0/24" 
}


resource "aws_vpc" "mainvpc" {

    cidr_block = "10.0.0.0/16"
    provider = "aws.ohio"
}

resource "aws_subnet" "prod" {
    vpc_id = aws_vpc.mainvpc.id
    cidr_block= "10.0.1.0/24"
    provider = "aws.ohio" 
}

resource "aws_subnet" "dev" {
    vpc_id = aws_vpc.mainvpc.id
    cidr_block= "10.0.2.0/24"
    provider = "aws.ohio" 
}


