# Terraform IaC Project - AWS VPC + EC2 + Nginx

Provisioning AWS infrastructure using Terraform with a flat file structure.

## What This Project Does

- Creates a custom VPC with public and private subnets
- Sets up an Internet Gateway and Route Table for public internet access
- Launches an EC2 instance in the public subnet
- Installs and starts Nginx automatically on boot
- Uses a Security Group to allow HTTP (port 80) and SSH (port 22)

## Tech Stack

- Terraform
- AWS (VPC, EC2, Security Group, IGW, Route Table)
- Nginx
- Amazon Linux 2

## File Structure
- provider.tf       # AWS provider and region configuration
- variables.tf      # Input variable declarations
- terraform.tfvars  # Actual credential values (not pushed to GitHub)
- data.tf           # Fetches latest Amazon Linux AMI dynamically
- resources.tf      # All AWS resources

## How to Run

1. Clone the repo
2. Create a `terraform.tfvars` file with your AWS credentials:
    - aws_access_key = "your-access-key"
    - aws_secret_key = "your-secret-key"    
## Run the following commands:
     terraform init
     terraform plan
     terraform apply
3. After apply, copy the EC2 public IP and open it in your browser to see Nginx running

## How to Destroy
     terraform destroy

## Key Concepts Covered

- Custom VPC with CIDR block
- Public and private subnet design
- Internet Gateway and Route Table association
- Security Group as EC2 firewall
- Dynamic AMI fetch using data source
- User data script for bootstrapping Nginx
- Credential security using tfvars and gitignore 
