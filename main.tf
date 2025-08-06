data "aws_vpc" "default" {
  default = true
}

resource "aws_key_pair" "deployer" {
  key_name   = "my-key"
  public_key = file("~/.ssh/id_rsa.pub")
}

resource "aws_security_group" "ec2_sg" {
  name        = "ec2-security-group"
  description = "Allow SSH and HTTP"
  vpc_id      = data.aws_vpc.default.id

  ingress {
    from_port   = 22
    to_port     = 22
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  ingress {
    from_port   = 80
    to_port     = 80
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }
}

resource "aws_instance" "web_server" {
  ami                    = var.ami
  instance_type          = var.instance_type
  key_name               = aws_key_pair.deployer.key_name
  vpc_security_group_ids = [aws_security_group.ec2_sg.id]

  user_data = var.user_data

  tags = {
    Name = "Terraform_EC2"
  }
}

resource "aws_ebs_volume" "block_storage" {
  availability_zone = aws_instance.web_server.availability_zone
  size              = var.ebs_volume_size
  type              = var.ebs_type

  tags = {
    Name = "block_store"
  }
}

resource "aws_volume_attachment" "ebs_attach" {
  device_name = "/dev/xvdf"
  volume_id   = aws_ebs_volume.block_storage.id
  instance_id = aws_instance.web_server.id
}
