provider "aws" {
    region = "us-east-1"  
}

resource "aws_instance" "foo" {
  ami           = "ami-0332d564d76dbd8d6" 
  instance_type = "t3.small"
  tags = {
      Name = "Terraform-Instance"
  }
}
