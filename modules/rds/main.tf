resource "aws_db_subnet_group" "db_subnets" {
  name       = "rds-subnets"
  subnet_ids = var.subnet_ids

  tags = {
    Module = "RDS"
  }
}

resource "aws_security_group" "rds_sg" {
  name        = "rds-sg"
  description = "Permit DB access from EC2"
  vpc_id      = var.vpc_id

  ingress {
    description = "Allow MySQL/Postgres Access"
    from_port   = 3306
    to_port     = 3306
    protocol    = "tcp"
    cidr_blocks = ["10.0.0.0/8"]
  }

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }

  tags = {
    Module = "RDS"
  }
}

resource "aws_db_instance" "db" {
  identifier              = var.identifier
  engine                  = "mysql"
  instance_class          = "db.t3.micro"
  allocated_storage       = 20

  name                    = var.db_name
  username                = var.username
  password                = var.password

  db_subnet_group_name    = aws_db_subnet_group.db_subnets.name
  vpc_security_group_ids  = [aws_security_group.rds_sg.id]

  skip_final_snapshot     = true

  tags = {
    Module = "RDS"
  }
}

