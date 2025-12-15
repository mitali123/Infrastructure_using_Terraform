resource "aws_security_group" "ec2_sg" {
  name        = "ec2-sg"
  description = "Security group for EC2 instance"
  vpc_id      = var.vpc_id

  ingress {
    description = "Allow SSH"
    from_port   = 22
    to_port     = 22
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  ingress {
    description = "Allow HTTP"
    from_port   = 80
    to_port     = 80
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  egress {
    description = "Allow all outbound"
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }

  tags = {
    Module = "EC2"
  }
}

resource "aws_instance" "app" {
  ami           = var.ami_id
  instance_type = "t2.micro"
  subnet_id     = var.subnet_id
  key_name      = var.key_name
  vpc_security_group_ids = [aws_security_group.ec2_sg.id]

  tags = {
    Name   = "test-ec2"
    Module = "EC2"
  }
}
