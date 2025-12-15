variable "hosted_zone_id" {
  description = "The Route53 Hosted Zone ID"
  type        = string
}

variable "record_name" {
  description = "Record name (e.g., app.example.com)"
  type        = string
}

variable "alb_dns_name" {
  description = "DNS name of the Application Load Balancer"
  type        = string
}

variable "alb_zone_id" {
  description = "Zone ID of the ALB"
  type        = string
}
