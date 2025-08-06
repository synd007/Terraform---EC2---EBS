# TERRAFORM PROJECT: EC2 with EBS Volume (AMAZON LINUX 2)

This project provisions an EC2 instance and attaches an EBS volume using Terraform. The instance is configured to serve a basic web page stored on the mounted volume.


# FEATURES
- EC2 instance (t2.micro, Free Tier eligible)
- EBS volume (8GB, gp2)
- Automatic volume formatting and mounting
- Apache web server installation
- Web page served from EBS volume
- SSH and HTTP security group rules

# FILE STRUCTURE
ec2-ebs-terraform/
├── main.tf
├── variables.tf
├── outputs.tf
├── .gitignore
└── README.md


# REQUIREMENTS
- Terraform
- AWS CLI with configured credentials (aws configure)
- SSH key at ~/.ssh/id_rsa.pub

# HOW TO USE
- Initialize Terraform
terraform init
- Preview the plan
terraform plan
- Apply the changes
terraform apply


# OUTPUT
The public IP address of the EC2 instance is printed on completion.
Visit the IP in a browser to view the hosted page.

Dont forget to destroy the test infrastructure using "Terraform destroy"
