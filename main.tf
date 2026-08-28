provider "aws" {
    region = "us-east-1"  
}

resource "aws_instance" "server" {
  ami           = "ami-0332d564d76dbd8d6" 
  instance_type = "t3.micro"
  tags = {
      Name = "Terraform-Instance"
  }
}
