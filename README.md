# ⚠️ WIP

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

## VPC Module

This Terraform module provisions a Virtual Private Cloud (VPC) with essential networking resources including a public subnet, Internet Gateway, route table, and a security group for SSH access. It is designed to be reusable and environment-agnostic with a focus on modularity and security.

### Features

* Creates a custom VPC with specified CIDR block
* Provisions a public subnet with optional public IP assignment
* Attaches an Internet Gateway for public access
* Creates a route table with default route to the Internet
* Associates the route table to the subnet
* Configures a security group for SSH access
* Applies consistent tagging for all resources

### Module Structure

```
modules/
└── vpc/
    ├── datasources.tf
    ├── main.tf
    ├── variables.tf
    └── outputs.tf
```

### Usage

Example usage in your root `main.tf`:

```hcl
module "vpc" {
  source                           = "./modules/vpc"
  vpc_cidr_block                   = "10.0.0.0/16"
  vpc_tags                         = {
                                       Name = "main-vpc"
                                       Env  = "dev"
                                     }

  subnet_cidr_block               = "10.0.1.0/24"
  subnet_availability_zone       = "us-west-2a"
  subnet_map_public_ip_on_launch = true
  subnet_tags                    = {
                                     Name = "public-subnet"
                                     Env  = "dev"
                                   }

  gateway_tags                   = {
                                     Name = "igw"
                                     Env  = "dev"
                                   }

  route_cidr_block               = "0.0.0.0/0"
  route_tags                     = {
                                     Name = "public-route"
                                     Env  = "dev"
                                   }

  ssh_name                       = "allow-ssh"
  ssh_description                = "Allow SSH access"
  ssh_ingress_rules             = [
                                     {
                                       from_port   = 22
                                       to_port     = 22
                                       protocol    = "tcp"
                                       cidr_blocks = ["0.0.0.0/0"]
                                     }
                                   ]
  egress_rules                  = [
                                     {
                                       from_port   = 0
                                       to_port     = 0
                                       protocol    = "-1"
                                       cidr_blocks = ["0.0.0.0/0"]
                                     }
                                   ]
  ssh_tags                       = {
                                     Name = "ssh-sg"
                                     Env  = "dev"
                                   }
}
```

### Input Variables

| Name                             | Description                                                | Type         | Default |
| -------------------------------- | ---------------------------------------------------------- | ------------ | ------- |
| `vpc_cidr_block`                 | CIDR block for the VPC                                     | string       | n/a     |
| `vpc_tags`                       | Tags to apply to the VPC                                   | map(string)  | n/a     |
| `subnet_cidr_block`              | CIDR block for the public subnet                           | string       | n/a     |
| `subnet_availability_zone`       | Availability zone for the subnet                           | string       | n/a     |
| `subnet_map_public_ip_on_launch` | Whether to assign public IPs on instance launch            | bool         | n/a     |
| `subnet_tags`                    | Tags to apply to the subnet                                | map(string)  | n/a     |
| `gateway_tags`                   | Tags to apply to the Internet Gateway                      | map(string)  | n/a     |
| `route_cidr_block`               | Destination CIDR block for the route (usually `0.0.0.0/0`) | string       | n/a     |
| `route_tags`                     | Tags to apply to the route table                           | map(string)  | n/a     |
| `ssh_name`                       | Name of the security group                                 | string       | n/a     |
| `ssh_description`                | Description of the security group                          | string       | n/a     |
| `ssh_ingress_rules`              | Ingress rules for the security group                       | list(object) | n/a     |
| `egress_rules`                   | Egress rules for the security group                        | list(object) | n/a     |
| `ssh_tags`                       | Tags to apply to the security group                        | map(string)  | n/a     |

### Security Best Practices Implemented

* **Network Segmentation**: VPC and subnetting allow fine-grained traffic control.
* **Internet Access Control**: Explicit use of route table and Internet Gateway.
* **SSH Access Restriction**: Only allows SSH from specified CIDRs.
* **Least Privilege**: No open access beyond what is defined in ingress/egress rules.
* **Tagging**: All resources are consistently tagged for traceability and governance.

### Outputs

You can reference these outputs in your root module:

| Output Name          | Description                  |
| -------------------- | ---------------------------- |
| `vpc_id`             | ID of the created VPC        |
| `subnet_id`          | ID of the public subnet      |
| `security_group_ids` | ID of the SSH security group |

### License

This module is provided as-is without warranty. Use at your own risk.

---

**Note**: Always review and restrict security group CIDR blocks. Avoid `0.0.0.0/0` in production unless strictly necessary.

---

## ALB Module

This Terraform module provisions an **Application Load Balancer (ALB)** with a target group and optional listeners. It supports health checks, customizable ports and protocols, and is designed to be reused across multiple environments.

### Features

* Provisions a Load Balancer with support for HTTP(S) protocols
* Creates a target group with custom health check configuration
* Allows listener and listener rule setup
* Accepts environment-specific tagging
* Works with any VPC and subnet configuration

### Module Structure

```
modules/
└── alb/
    ├── main.tf
    ├── variables.tf
    └── outputs.tf
```

### Usage

Example usage in your root `main.tf`:

```hcl
module "alb" {
  source                 = "./modules/alb"
  alb_name               = "myapp-alb"
  internal               = false
  load_balancer_type     = "application"
  security_groups        = ["sg-0123456789abcdef0"]
  subnets                = ["subnet-123", "subnet-456"]
  target_group_name      = "myapp-tg"
  target_group_port      = 80
  target_group_protocol  = "HTTP"
  vpc_id                 = "vpc-0123456789abcdef0"
  health_check_path      = "/health"
  health_check_interval  = 30
  health_check_timeout   = 5
  healthy_threshold      = 2
  unhealthy_threshold    = 2
  health_check_matcher   = "200-299"
  tags                   = {
                             Name = "alb-dev"
                             Env  = "dev"
                             Iac  = true
                           }
}
```

### Input Variables

| Name                    | Description                                            | Type         | Default         |
| ----------------------- | ------------------------------------------------------ | ------------ | --------------- |
| `alb_name`              | Name of the ALB                                        | string       | n/a             |
| `internal`              | Whether the ALB is internal or internet-facing         | bool         | `false`         |
| `load_balancer_type`    | Type of load balancer (e.g., "application")            | string       | `"application"` |
| `security_groups`       | List of security group IDs to associate with the ALB   | list(string) | n/a             |
| `subnets`               | List of subnet IDs where the ALB will be placed        | list(string) | n/a             |
| `target_group_name`     | Name of the target group                               | string       | n/a             |
| `target_group_port`     | Port for the target group                              | number       | n/a             |
| `target_group_protocol` | Protocol for the target group (e.g., "HTTP")           | string       | `"HTTP"`        |
| `vpc_id`                | VPC ID for the target group                            | string       | n/a             |
| `health_check_path`     | Path used by health check                              | string       | `"/"`           |
| `health_check_interval` | Time between health checks (in seconds)                | number       | `30`            |
| `health_check_timeout`  | Health check timeout (in seconds)                      | number       | `5`             |
| `healthy_threshold`     | Number of successful checks before considering healthy | number       | `2`             |
| `unhealthy_threshold`   | Number of failed checks before considering unhealthy   | number       | `2`             |
| `health_check_matcher`  | HTTP status codes to match for success                 | string       | `"200"`         |
| `tags`                  | Tags to apply to all resources                         | map(string)  | `{}`            |

### Security Best Practices Implemented

* **Scoped Subnet Association**: Load balancer is tied to specific subnets for better control
* **Health Check Monitoring**: Helps detect instance issues automatically
* **Custom Security Groups**: Allow fine-grained traffic control
* **Environment Tags**: Useful for governance, billing, and resource filtering

### Outputs

| Output Name        | Description                      |
| ------------------ | -------------------------------- |
| `alb_arn`          | ARN of the created Load Balancer |
| `alb_dns_name`     | DNS name of the ALB              |
| `target_group_arn` | ARN of the target group          |

### License

This module is provided as-is without warranty. Use at your own risk.

---

**Note**: Ensure that appropriate listener and listener rule resources are added if you're not handling those in another module.