terraform {
  required_providers {
    aws = {
        source = "hashicorp/aws"
        version = "~> 4.16"
    }
  }
  required_version = ">= 1.2.0"
}

provider "aws" {
  region = "us-east-1"
}

variable "public-key" {
  type = string
  default = "ssh-rsa AAAAB3NzaC1yc2EAAAADAQABAAACAQDBei09arqD70lDfhbb7axzgrVQlQtP7PEqcm/z5ryJP0823kpnP9eJLTYiodD/wQBuedK96VRolGsA62hf9RltY/AYyz1np2bkU6cU1qbJqRQZaejtIBr1KiOPQfVnkkLo6cmgzUnPcSUI0Q8eGjW+4qnL1oMdkgOlKREUK5rzjI5Y3xNGKc9gW1VZ9khOTKVZmo8b0eowCQv3IzOpBSzXxFvLB6aeWIa32XgTvxzKvmGRYQkZObeVkOhAT5Hlj0QBZCF10ZiA7xUquovaluUdxXtZe+QOTQNPqhXOwdBJkAZHbu26T5rRrvg2AeEYzHU7PNYQJOSeDethVxFzKW4RFMJTxNrvdiJQ40xanhq7wk1N4VQfrC0gHu+0ipYXxvM2+xXitU49c/+PNBqf8dzd8IfL//M4PA5Lp01bgOdeGdawoALupXhfMKvIVcDqmDjJacPMTpnto+hehiFRhjC3TaxzSpxTUiMXHi4FX97RHZjI3vbpFm8ui5HV/JAgOddP/DbKE/UVKC8afWKepE2DhtKhtryJwJVUVaftKAXnw5IziUyRZRX76pzpSFtPtQZEIUZ43seyU1P99x/TGcw3PdYSzAGUlh1p2jc+u2HA0ib7ezy5hKgSCAJIY1V2MvmBaJtSVA84fj2d8hMYgtSDaBfjVTxopHTHT1iA9frZ/Q== hp@DESKTOP-H0VKNKS"
}

variable "key-pair-name" {
  type = string
  default = terra-key-pair
}

resource "aws_key_pair" "terra-key" {
  key_name = var.key-pair-name
  public_key = var.public-key
}

resource "aws_vpc" "terra-vpc" {
  cidr_block = "192.16.0.0/16"

  tags = {
    name = "terraform"
  }
}

resource "aws_security_group" "terra-SG" {
  name = "terra-SG"
  description = "terra-SG"
  vpc_id = aws_vpc.terra-vpc.id

  ingress = [ {
    description = "SSH connect"
    from_port = 22
    ipv4_cidr_blocks = [ "0.0.0.0/0" ]
    protocol = "tcp"
    to_port = 22
  },
  {
    description = "Http access on port 80"
    from_port = 80
    to_port = 80
    ipv4_cidr_blocks = ["0.0.0.0/0"]
    protocol = "tcp"
  }]

  egress = [ {
    cidr_blocks = [ "0.0.0.0/0" ]
    description = "Allow all outbound traffic"
    from_port = 0
    protocol = "-1"
    to_port = 0
  } ]
}

resource "aws_instance" "my-first-terraform-instance" {
  ami = "ami-0263e4deb427da90e"
  instance_type = "t2.micro"
  key_name = terra-key
  vpc_security_group_ids = [ "aws_security_group.terra-SG.id" ]
  associate_public_ip_address = true
  root_block_device {
    volume_type = "gp2"
    volume_size = "10"
  }
  
  tags = {
    name = "vprofile"
    project = "vprofile"
  }

depends_on = [
  aws_key_pair.terra-key
]

  user_data = "${file("terra.sh")}"
}