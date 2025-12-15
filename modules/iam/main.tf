resource "aws_iam_role" "ec2_role" {
  name = "test-ec2-role"

  assume_role_policy = jsonencode({
    Version = "2012-10-17",
    Statement = [{
      Effect = "Allow",
      Principal = { Service = "ec2.amazonaws.com" },
      Action = "sts:AssumeRole"
    }]
  })

  tags = {
    Module = "IAM"
  }
}

resource "aws_iam_role_policy" "ec2_policy" {
  name = "test-ec2-policy"
  role = aws_iam_role.ec2_role.id

  policy = jsonencode({
    Version = "2012-10-17",
    Statement = [{
      Effect = "Allow",
      Action = ["s3:*"],
      Resource = "*"
    }]
  })
}
