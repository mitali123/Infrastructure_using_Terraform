variable "db_name" {
  description = "Name of the initial database to create inside the RDS instance."
  type        = string
}

variable "username" {
  description = "Master username for the RDS database instance."
  type        = string
}

variable "password" {
  description = "Master password for the RDS database instance."
  type        = string
  sensitive   = true
}

variable "identifier" {
  description = "Unique identifier for the RDS instance."
  type        = string
}

variable "subnet_ids" {
  description = "List of private subnet IDs used to create the RDS subnet group."
  type        = list(string)
}

variable "vpc_id" {
  description = "VPC ID where the RDS instance and its associated security group are deployed."
  type        = string
}

