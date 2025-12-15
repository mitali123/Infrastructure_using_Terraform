#LB security group
resource "aws_security_group" "alb" {
  name        = "app_load_balancer"
  description = "forward to instances"
  vpc_id      = "${var.vpc_id}"

  ingress {
    description = "allow https traffic on port 443"
    from_port   = 443
    to_port     = 443
    protocol    = "tcp"
    cidr_blocks     = ["0.0.0.0/0"]
  }

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }

  tags = {
    Name = "app_load_balancer"
  }
}

resource "aws_lb" "alb" {
  name               = "WebappLoadBalancer"
  internal           = false
  load_balancer_type = "application"
  security_groups    = ["${aws_security_group.alb.id}"]
  subnets            = var.public_subnet_ids

  tags = {
    Module = "ALB"
  }
}


resource "aws_lb_target_group" "alb_target_group" {  
  name     = "albTargetGroup"  
  port     = "3002"  
  protocol = "HTTP"  
  vpc_id   = "${var.vpc_id}"   
  tags = {    
    Name = "alb_target_group"    
  }   
  stickiness {    
    type            = "lb_cookie"    
    cookie_duration = 1800    
    enabled         = true  
  }   
    health_check {    
    healthy_threshold   = 3    
    unhealthy_threshold = 10  
    timeout             = 50    
    interval            = 52    
    path                = "/"    
  } 
}

resource "aws_alb_listener" "ssl_listener" {
  load_balancer_arn = aws_alb.lb.arn
  port              = "443"
  protocol          = "HTTPS"
  ssl_policy        = "ELBSecurityPolicy-2016-08"
  certificate_arn   = "${var.cert_arn}"
   
  default_action {
    target_group_arn = aws_lb_target_group.alb_target_group.arn
    type             = "forward"
  }
}

resource "aws_lb_target_group_attachment" "ec2_attach" {
  target_group_arn = aws_lb_target_group.alb_target_group.arn
  target_id        = var.instance_id
  port             = 80
}

#Autoscaling Attachment
resource "aws_autoscaling_attachment" "alb_asg" {
  alb_target_group_arn   = "${aws_lb_target_group.alb_target_group.arn}"
  autoscaling_group_name = "${aws_autoscaling_group.autoscale.id}"
}

