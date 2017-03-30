#
# DO NOT DELETE THESE LINES!
#
# Your AMI ID is:
#
#     ami-dde2debb
#
# Your subnet ID is:
#
#     subnet-316b4869
#
# Your security group ID is:
#
#     sg-6df82a14
#
# Your Identity is:
#
#     amazic-panda
#
variable "aws_access_key" {
  type = "string"
}

variable "aws_secret_key" {
  type = "string"
}

variable "aws_region" {
  type    = "string"
  default = "eu-west-1"
}

provider "aws" {
  #access_key = "AKIAI2NJUIPVDFAKVMCA"
  #secret_key = "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"
  access_key = "${var.aws_access_key}"

  secret_key = "${var.aws_secret_key}"
  region     = "${var.aws_region}"
}

resource "aws_instance" "web" {
  ami                    = "ami-dde2debb"
  instance_type          = "t2.micro"
  subnet_id              = "subnet-316b4869"
  vpc_security_group_ids = ["sg-6df82a14"]
  count                  = "2"

  tags {
    Identity = "amazic-panda"
    blah     = "yada"
    blah2    = "yada"
    Name     = "web ${count.index+1}"
  }
}

output "public_dns" {
  value = ["${aws_instance.web.*.public_dns}"]
}

output "public_ip" {
  value = ["${aws_instance.web.*.public_ip}"]
}
