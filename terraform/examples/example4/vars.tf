variable "REGION" {
  default = "us-east-2"
}

variable "ZONE1" {
  default = "us-east-2a"
}

variable "AMIS" {
  type = map(any)
  default = {
    us-east-2 = "ami-0283a57753b18025b"
    us-east-1 = "ami-0beaa649c482330f7"
  }
}

variable "USER" {
  default = "ubuntu"
}
