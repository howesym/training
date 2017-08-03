#
# DO NOT DELETE THESE LINES!
#
# Your AMI ID is:
#
#     ami-b87299c1
#
# Your subnet ID is:
#
#     subnet-f0e85097
#
# Your security group ID is:
#
#     sg-b2a021ca
#
# Your Identity is:
#
#     Idol-training-grasshopper
#

terraform {
  backend  "atlas" {
    name = "howesym/training"
  }
}

variable "aws_access_key" {}
variable "aws_secret_key" {}

variable "aws_region" {
  default = "eu-west-1"
}

provider "aws" {
  secret_key = "${var.aws_secret_key}"
  access_key = "${var.aws_access_key}"
  region     = "${var.aws_region}"
}

resource "aws_instance" "web" {
  ami                    = "ami-b87299c1"
  instance_type          = "t2.micro"
  subnet_id              = "subnet-f0e85097"
  vpc_security_group_ids = ["sg-b2a021ca"]

  tags {
    "Identity" = "Idol-training-grasshopper"
    "name"     = "mark howes"
    "company"  = "theidol.com"
    "index"    = "${count.index}"
  }

  count = "2"
}

output "public_ip" {
  value = "${aws_instance.web.*.public_ip}"
}

output "public_dns" {
  value = "${aws_instance.web.*.public_dns}"
}

output "index" {
  value = ["${aws_instance.web.*.tags.index}"]
}
