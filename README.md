# 🚀 Challenge: Multi-Environment Infrastructure Setup

This repository contains the infrastructure-as-code (IaC) project developed to meet the challenge of creating a multi-environment setup using **Terraform** and **AWS**, applying best practices in organization, modularization, and security.

---

## 📌 Objective

The goal is to implement a cloud infrastructure with three separate environments:

- `dev` (development)
- `staging` (pre-production)
- `prod` (production)

Each environment must have isolated resources, specific configurations, and share reusable infrastructure modules.

---

## 🧱 Proposed Architecture

Each environment includes:

- A VPC with public and private subnets
- EC2 instances with environment-specific instance types
- Application Load Balancer (ALB)
- Security Groups with restricted access rules
- Sensitive variables stored in **AWS Secrets Manager**
- Environments separated using folders or workspaces

---

## 📁 Project Structure

## EBS Module

This Terraform module provisions a secure Amazon EBS volume and attaches it to an EC2 instance. It includes encryption using AWS KMS, proper tagging, and optional customization for different environments.

### Features

- Creates an encrypted EBS volume using a dedicated KMS key
- Enables automatic key rotation
- Tags resources with project and environment identifiers
- Attaches the EBS volume to an EC2 instance

### Module Structure

```
modules/
└── ebs/
    ├── main.tf
    └── variables.tf
    └── outputs.tf
```

### Usage

Example usage in your root `main.tf`:

```hcl
module "ebs" {
  source            = "./modules/ebs"
  ebs_name      = "myapp"
  availability_zone = "us-west-2a"
  ami_id            = "ami-xxxxxxxx"
  key_name          = "my-key"
  subnet_id         = "subnet-xxxxxxxx"
  environment       = "dev"
}
```

### Input Variables

| Name              | Description                                         | Type   | Default     |
|-------------------|-----------------------------------------------------|--------|-------------|
| ebs_name          | Prefix for naming resources                         | string | n/a         |
| availability_zone | AWS availability zone (e.g., us-west-2a)            | string | n/a         |
| ebs_size          | Size of the EBS volume in GB                        | number | `20`        |
| ebs_type          | EBS volume type (e.g., gp3, io1)                    | string | `gp3`       |
| ami_id            | AMI ID for the EC2 instance                         | string | n/a         |
| instance_type     | EC2 instance type                                   | string | `t3.micro`  |
| key_name          | EC2 SSH key name                                    | string | n/a         |
| subnet_id         | Subnet ID for EC2                                   | string | n/a         |
| device_name       | Device name for volume attachment (e.g., /dev/sdh)  | string | `/dev/sdh`  |
| tags              | Define tags (e.g., Iac = true)                      | map(string) | name, iac       |

### Security Best Practices Implemented

- **Encryption**: The EBS volume is encrypted using a customer-managed KMS key.
- **Key Rotation**: Automatic KMS key rotation is enabled for long-term security.
- **Access Control**: By using customer-managed KMS, fine-grained IAM policies can be applied to restrict key usage.
- **Tagging**: Resources are tagged for better visibility and access management.

### Outputs

No outputs are explicitly defined in this module. You can extend it to export instance IDs, volume ARNs, etc.

### License

This module is provided as-is without warranty. Use at your own risk.

---

**Note**: Always ensure IAM policies are properly scoped to limit access to the KMS key and EC2 instance as needed.



