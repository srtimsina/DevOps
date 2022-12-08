provider "aws" {
  region = "us-east-2"
}
resource "aws_instance" "devops-morning-tf-instance1" {
  ami                    = "ami-0283a57753b18025b"
  instance_type          = "t2.micro"
  availability_zone      = "us-east-2a"
  key_name               = "devops-test"
  vpc_security_group_ids = ["sg-0f461805e81530424"]
  tags = {
    Name    = "devops_instace"
    Project = "DevOps"
  }
}
