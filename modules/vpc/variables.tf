variable "vpc_cidr" {
  description = "CIDR block for the VPC, defining the overall IP address range for the network."
  type        = string
}

variable "vpc_name" {
  description = "Name assigned to the VPC for identification and tagging purposes."
  type        = string
}

variable "public_subnet1_cidr" {
  description = "CIDR block for the first public subnet, typically used for internet-facing resources such as load balancers."
  type        = string
}

variable "public_subnet2_cidr" {
  description = "CIDR block for the second public subnet, deployed in a different availability zone for high availability."
  type        = string
}

variable "public_subnet3_cidr" {
  description = "CIDR block for the third public subnet, providing additional fault tolerance across availability zones."
  type        = string
}

variable "private_subnet1_cidr" {
  description = "CIDR block for the first private subnet, used for application servers and internal services."
  type        = string
}

variable "private_subnet2_cidr" {
  description = "CIDR block for the second private subnet, deployed in a separate availability zone for resilience."
  type        = string
}

variable "private_subnet3_cidr" {
  description = "CIDR block for the third private subnet, improving availability and scalability across zones."
  type        = string
}

variable "az1" {
  description = "First AWS availability zone used to distribute resources for high availability."
  type        = string
}

variable "az2" {
  description = "Second AWS availability zone used to ensure fault tolerance across the region."
  type        = string
}

variable "az3" {
  description = "Third AWS availability zone used to further enhance availability and resilience."
  type        = string
}
