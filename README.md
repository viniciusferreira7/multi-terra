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
    ├── datasources.tf
    ├── main.tf
    └── variables.tf
    └── outputs.tf
```

### Usage

Example usage in your root `main.tf`:

```hcl
module "ebs" {
  source            = "./modules/ebs"
  name      = "myapp"
  availability_zone = "us-west-2a"
  size          = "20"
  ec2_id            = "xxxxxxxx"
  tags              = {
                        Name = "example"
                        Iac = true
                      }

}
```

### Input Variables

| Name              | Description                                         | Type   | Default     |
|-------------------|-----------------------------------------------------|--------|-------------|
| name          | Prefix for naming resources                         | string | n/a         |
| availability_zone | AWS availability zone (e.g., us-west-2a)            | string | n/a         |
| size          | Size of the EBS volume in GB                        | number | `20`        |
| type          | EBS volume type (e.g., gp3, io1)                    | string | `gp3`       |
| tags              | Define tags (e.g., Iac = true)                      | map(string) | name, iac       |
| ec2_id               | Define ID of EC2                                    | string| n/a     |

### Security Best Practices Implemented

- **Encryption**: The EBS volume is encrypted using a customer-managed KMS key.
- **Key Rotation**: Automatic KMS key rotation is enabled for long-term security.
- **Access Control**: By using customer-managed KMS, fine-grained IAM policies can be applied to restrict key usage.
- **Tagging**: Resources are tagged for better visibility and access management.

### Outputs

You can extend the module to expose useful attributes like:

| Output Name   | Description                        |
| ------------- | ---------------------------------- |
| `ebs_volume_id`   | Volume of EBS  |

### License

This module is provided as-is without warranty. Use at your own risk.

---

**Note**: Always ensure IAM policies are properly scoped to limit access to the KMS key and EC2 instance as needed.


Aqui está uma documentação estilo `README.md` para um módulo Terraform de EC2, no mesmo formato que o exemplo de EBS:

---

## EC2 Module

This Terraform module provisions an Amazon EC2 instance with customizable configuration. It supports secure networking, key pair access, tagging, and root volume management. Designed for flexible use across environments like development, staging, and production.

### Features

* Creates an EC2 instance with configurable AMI and instance type
* Supports SSH access via key pair
* Enables public IP association for internet access
* Allows user data for bootstrapping
* Configurable root block device
* Supports IAM role attachment
* Tagging for environment and project tracking

### Module Structure

```
modules/
└── ec2/
    ├── datasources.tf
    ├── main.tf
    ├── variables.tf
    └── outputs.tf
```

### Usage

Example usage in your root `main.tf`:

```hcl
module "ec2" {
  source                        = "./modules/ec2"
  ami_id                        = "ami-0abcdef1234567890"
  instance_type                 = "t3.micro"
  key_name                      = "my-key"
  subnet_id                     = "subnet-0123456789abcdef0"
  security_group_ids            = ["sg-0123456789abcdef0"]
  associate_public_ip_address   = true
  iam_instance_profile          = "ec2-s3-role"
  user_data                     = <<-EOF
                                    #!/bin/bash
                                    sudo apt update -y
                                    sudo apt install nginx -y
                                  EOF
  root_volume_size              = 20
  root_volume_type              = "gp3"
  tags                          = {
                                    Name = "MyAppServer"
                                    Env  = "dev"
                                    Iac  = true
                                  }
}
```

### Input Variables

| Name                          | Description                                  | Type         | Default      |
| ----------------------------- | -------------------------------------------- | ------------ | ------------ |
| `ami_id`                      | ID of the AMI to use for the instance        | string       | n/a          |
| `instance_type`               | EC2 instance type (e.g., t3.micro)           | string       | `"t2.micro"` |
| `key_name`                    | Name of the SSH key pair                     | string       | n/a          |
| `subnet_id`                   | ID of the subnet to launch the instance into | string       | n/a          |
| `security_group_ids`          | List of security group IDs                   | list(string) | n/a          |
| `associate_public_ip_address` | Whether to associate a public IP             | bool         | `true`       |
| `iam_instance_profile`        | IAM instance profile name                    | string       | `null`       |
| `user_data`                   | User data script to run on boot              | string       | `""`         |
| `root_volume_size`            | Root volume size in GB                       | number       | `10`         |
| `root_volume_type`            | Root volume type (e.g., gp3, gp2)            | string       | `"gp2"`      |
| `tags`                        | Map of tags to assign to the instance        | map(string)  | `{}`         |

### Security Best Practices Implemented

* **SSH Access**: Controlled via key pair — no hardcoded credentials.
* **IAM Profile Support**: Allows fine-grained access control with IAM roles.
* **Minimal Exposure**: Public IP only if explicitly allowed.
* **Tagging**: Helps track infrastructure by environment, project, or owner.
* **User Data Scripts**: Provisioning can be done via script on instance creation.

### Outputs

You can extend the module to expose useful attributes like:

| Output Name   | Description                        |
| ------------- | ---------------------------------- |
| `ec2_id`   | ID of ECS  |

### License

This module is provided as-is without warranty. Use at your own risk.

---

**Note**: Always scope your IAM roles, security groups, and key pairs appropriately to follow the principle of least privilege.

---

Se quiser, posso incluir os blocos de `outputs.tf` também — deseja que eu adicione isso?
