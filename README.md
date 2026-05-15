# Highly Available VPC Architecture on AWS using Terraform

Provisions a production-style AWS network infrastructure using Terraform — multi-AZ VPC with public/private subnet isolation, NAT Gateway, and an Nginx EC2 instance.

---

## Architecture

- Custom VPC (`10.0.0.0/16`) with DNS support enabled
- 2 Public Subnets across `ap-south-1a` and `ap-south-1b`
- 6 Private Subnets across `ap-south-1a` and `ap-south-1b`
- Internet Gateway → Public Route Table (public internet access)
- NAT Gateway with Elastic IP → Private Route Tables (outbound only)
- Security Group with SSH (22) and HTTP (80) inbound rules
- EC2 instance (`t3.micro`, Amazon Linux) with Nginx auto-installed via User Data

---

## Project Structure

```
.
├── provider.tf       # AWS provider and region configuration
├── resources.tf      # All AWS resources
├── .gitignore        # Excludes state files and credentials
└── README.md
```

---

## Prerequisites

- Terraform installed
- AWS CLI configured
- IAM user with EC2 and VPC permissions

---

## Deploy

```bash
git clone <repo-url>
cd <repo-name>

terraform init
terraform validate
terraform plan
terraform apply
```

After apply, copy the EC2 public IP and open `http://<public-ip>` in your browser — you should see the Nginx welcome page.

---

## Destroy

```bash
terraform destroy
```

---

## Key Concepts Covered

- Multi-AZ subnet design with public and private isolation
- Internet Gateway for public subnet internet access
- NAT Gateway for private subnet outbound access
- Route Table associations per subnet tier
- Security Group as EC2 firewall (SSH + HTTP)
- Nginx bootstrapping via EC2 User Data
- Credential security using `.gitignore`

---

## Security Note

Do not hardcode AWS credentials in `provider.tf`.  
Recommended: remove `access_key` and `secret_key` from the provider block and use `aws configure` or an IAM role on EC2.

---

## Future Enhancements

- Application Load Balancer + Auto Scaling Group
- RDS (database tier)
- Bastion Host for private subnet access
- CloudWatch monitoring and alerts
- S3 backend for Terraform state
- Modular Terraform structure

---

## Author

Mohan M

AWS and DevOps Engineer (Fresher)

---

## Acknowledgement

This project was built under the guidance of my trainer as part of the AWS and DevOps hands-on training program. All implementation, configuration, and documentation was done by me.

---
