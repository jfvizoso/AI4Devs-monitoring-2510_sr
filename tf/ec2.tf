data "aws_ami" "amazon_linux" {
  most_recent = true
  owners      = ["amazon"]

  filter {
    name   = "name"
    values = ["amzn2-ami-hvm-*-x86_64-gp2"]
  }

  filter {
    name   = "state"
    values = ["available"]
  }
}

resource "aws_instance" "backend" {
  ami                    = data.aws_ami.amazon_linux.id
  instance_type          = "t3.micro"
  iam_instance_profile   = aws_iam_instance_profile.ec2_instance_profile.name
  user_data              = templatefile("${path.module}/scripts/backend_user_data.sh", { timestamp = timestamp(), dd_api_key = var.datadog_api_key, dd_site = "datadoghq.eu", code_bucket = aws_s3_bucket.code_bucket.bucket })
  vpc_security_group_ids = [aws_security_group.backend_sg.id]
  tags = {
    Name = "lti-project-backend"
    Datadog     = "true"
  }
}

resource "aws_instance" "frontend" {
  ami                    = data.aws_ami.amazon_linux.id
  instance_type          = "t3.micro"
  iam_instance_profile   = aws_iam_instance_profile.ec2_instance_profile.name
  user_data              = templatefile("${path.module}/scripts/frontend_user_data.sh", { timestamp = timestamp(), dd_api_key = var.datadog_api_key, dd_site = "datadoghq.eu", code_bucket = aws_s3_bucket.code_bucket.bucket })
  vpc_security_group_ids = [aws_security_group.frontend_sg.id]
  tags = {
    Name = "lti-project-frontend"
    Datadog     = "true"
  }
}

