resource "aws_instance" "vm" {
  ami           = "ami-0005e0cfe09cc9050" #linux  
  instance_type = "t2.micro"
  user_data     = file("user_data.sh")
  iam_instance_profile = aws_iam_instance_profile.profile.name

  vpc_security_group_ids      = [aws_security_group.security_group.id]
  associate_public_ip_address = true

  tags = {
    Name = "ec2-web"
  }

  depends_on = [
    aws_security_group.security_group,
    aws_iam_instance_profile.profile
  ]
}