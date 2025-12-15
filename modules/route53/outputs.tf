output "route53_record_fqdn" {
  description = "The FQDN of the created Route53 record"
  value       = aws_route53_record.alb_record.fqdn
}
