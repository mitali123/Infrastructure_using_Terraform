resource "aws_route53_record" "alb_record" {
  zone_id = var.hosted_zone_id
  name    = var.record_name
  type    = "A"

  alias {
    name                   = var.alb_dns_name
    zone_id                = var.alb_zone_id
    evaluate_target_health = true
  }

  lifecycle {
    create_before_destroy = true
  }

  tags = {
    Module = "Route53"
  }
}
