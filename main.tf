provider "aws" {

region = "us-east-1"
access_key = "AKIAYMXIVOYO2SQE757P"
secret_key = "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" 

}

resource "aws_vpc" "TestVPC" {
  cidr_block = "10.10.0.0/16"
  tags = {
    Name = "TestVPC"
  }
}

resource "aws_subnet" "Test1" {

  vpc_id     = aws_vpc.TestVPC.id
  cidr_block = "10.10.1.0/24"
  availability_zone = "us-east-1a"

  tags = {
    Name = "Dev"
  }

  
}

resource "aws_security_group" "TSec" {
    
    ingress {
        from_port = any
        to_port = 22
        protocol = "tcp"
        cidr_blocks = ["0.0.0.0/0"]
}

ingress {
        from_port = any
        to_port = any
        protocol = any
        cidr_blocks = ["0.0.0.0/0"]
}



}

resource "aws_instance" "example" {

    ami = "ami-0fb653ca2d3203ac1"
    instance_type = "t2.micro"
    availability_zone = "us-east-1a"
    subnet_id = aws_subnet.Test1.id
    vpc_security_group_ids = aws_security_group.Tsec.id
    
    tags = {
      Name = "terraform-example"
  }

}

