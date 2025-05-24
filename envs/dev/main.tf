module "vpc" {
  source         = "../../modules/vpc"
  vpc_cidr_block = var.vpc_cidr_block
  vpc_tags = {
    Name = "main-vpc"
    Env  = var.environment
  }

  subnet_cidr_block              = var.subnet_cidr_block
  subnet_availability_zone       = var.subnet_availability_zone
  subnet_map_public_ip_on_launch = true
  subnet_tags = {
    Name = "public-subnet"
    Env  = var.environment
  }

  gateway_tags = {
    Name = "igw"
    Env  = var.environment
  }

  route_cidr_block = var.route_cidr_block
  route_tags = {
    Name = "public-route"
    Env  = var.environment
  }

  ssh_name        = "allow-ssh"
  ssh_description = "Allow SSH access"
  ssh_ingress_rules = [
    {
      from_port   = 22
      to_port     = 22
      protocol    = "tcp"
      cidr_blocks = var.ssh_cidr_blocks
    }
  ]
  egress_rules = [
    {
      from_port   = 0
      to_port     = 0
      protocol    = "-1"
      cidr_blocks = ["0.0.0.0/0"]
    }
  ]
  ssh_tags = {
    Name = "ssh-sg"
    Env  = var.environment
  }
}

module "ec2" {
  source                      = "../../modules/ec2"
  ami_id                      = var.ami_id
  instance_type               = var.instance_type
  key_name                    = var.key_name
  subnet_id                   = module.vpc.subnet_id
  security_group_ids          = [module.vpc.security_group_ids]
  associate_public_ip_address = true
  iam_instance_profile        = var.iam_instance_profile
  user_data                   = <<-EOF
    #!/bin/bash
    sudo apt update -y
    sudo apt install nginx -y
  EOF
  root_volume_size            = 20
  root_volume_type            = "gp3"
  tags = {
    Name = "Ec2-${var.environment}"
    Env  = var.environment
    Iac  = true
  }
  depends_on = [module.vpc]
}

module "ebs" {
  source              = "../../modules/ebs"
  name                = "ebs_instance"
  availability_zone   = var.subnet_availability_zone
  size                = "20"
  ec2_id              = module.ec2.id
  enable_key_rotation = true
  tags = {
    Name = "ebs_instance-${var.environment}"
    Env  = var.environment
    Iac  = true
  }
  depends_on = [module.ec2]
}

module "alb" {
  source                 = "../../modules/alb"
  alb_name               = var.alb_name
  alb_internal           = false
  alb_type               = "application"
  alb_security_group_ids = [module.vpc.security_group_ids]
  alb_subnet_ids         = [module.vpc.subnet_id]
  target_id              = module.ec2.id
  target_group_name      = var.target_group_name
  target_group_port      = 80
  target_group_protocol  = "HTTP"
  vpc_id                 = module.vpc.vpc_id
  health_check_path      = "/health"
  health_check_interval  = 30
  health_check_timeout   = 5
  healthy_threshold      = 2
  unhealthy_threshold    = 2
  health_check_matcher   = "200-299"
  tags = {
    Name = "alb-${var.environment}"
    Env  = var.environment
    Iac  = true
  }
  depends_on = [
    module.vpc,
    module.ec2
  ]
}