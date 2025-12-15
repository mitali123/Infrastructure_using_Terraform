variable "ami_id" {
  description = "AMI ID used for EC2 instance deployment (e.g., Amazon Linux 2 AMI)."
  type        = string
}

variable "key_name" {
  description = "Key pair name used for SSH access to EC2 instances."
  type        = string
}

variable "subnet_id" {
  description = "ID of the subnet where the resource will be deployed."
  type        = string
}

variable "vpc_id" {
  description = "ID of the VPC in which the resource and its associated networking components are created."
  type        = string
}

