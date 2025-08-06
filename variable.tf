variable "instance_type" {
  default = "t2.micro"
}

variable "ami" {
  default = "ami-08a6efd148b1f7504"
}

variable "ebs_volume_size" {
  default = 8
}

variable "ebs_type" {
  default = "gp2"
}

variable "user_data" {
  default = <<-EOF
              #!/bin/bash
              mkfs.ext4 /dev/xvdf
              mkdir /data
              mount /dev/xvdf /data
              echo "/dev/xvdf /data ext4 defaults,nofail 0 2" >> /etc/fstab
              yum update -y
              yum install -y httpd
              echo " EC2 EBS Terraform Test Project!" > /data/index.html
              rm -rf /var/www/html
              ln -s /data /var/www/html
              systemctl start httpd
              systemctl enable httpd
              EOF
}