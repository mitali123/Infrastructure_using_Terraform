variable "public_subnet_ids" {
  description = "subnet ids of public subnets"
  type = list(string)
}

variable "vpc_id" {
  description = "ID of the VPC in which the resource and its associated networking components are created."
  type        = string
}

variable "instance_id" {
  description = "ID of EC2 instance to attach to ALB"
  type = string
}

variable "cert_arn" {
  description = "arn of ssl cert"
  type = string
}