
resource "aws_iam_instance_profile" "profile" {
  name = "ec2-log-s3-role"
  role = aws_iam_role.role.name
}

resource "aws_iam_role" "role" {
  name        = "ec2-log-s3-role"
  path               = "/"

  assume_role_policy = jsonencode({
    Version = "2012-10-17"
    Statement = [
      {
        Effect = "Allow"
        Principal = {
          Service = "ec2.amazonaws.com"
        },
        Action = "sts:AssumeRole"
      },
    ]
  })
  
  inline_policy {
    name = "my_inline_policy"

    policy = jsonencode({
      Version = "2012-10-17"
      Statement = [
        {
          Action   = ["s3:PutObject"]
          Effect   = "Allow"
          Resource = "arn:aws:s3:::my-log-bucket-lohan-2024/*"
        },
      ]
    })
  }
}