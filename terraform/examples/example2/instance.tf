resource "aws_instance" "devops-inst" {
  ami                    = var.AMIS[var.REGION]
  instance_type          = "t2.micro"
  availability_zone      = var.ZONE1
  key_name               = "devops-test"
  vpc_security_group_ids = ["sg-0f461805e81530424"]
  tags = {
    Name    = "devops_instace"
    Project = "DevOps"
    ManagedBy = "Terraform"
  }
}
