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

