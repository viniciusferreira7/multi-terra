module "vpc" {
  source         = "../../modules/vpc"
  vpc_cidr_block = "10.0.0.0/16"
  vpc_tags = {
    Name = "main-vpc"
    Env  = "dev"
  }

  subnet_cidr_block              = "10.0.1.0/24"
  subnet_availability_zone       = "us-east-1"
  subnet_map_public_ip_on_launch = true
  subnet_tags = {
    Name = "public-subnet"
    Env  = "dev"
  }

  gateway_tags = {
    Name = "igw"
    Env  = "dev"
  }

  route_cidr_block = "0.0.0.0/0"
  route_tags = {
    Name = "public-route"
    Env  = "dev"
  }

  ssh_name        = "allow-ssh"
  ssh_description = "Allow SSH access"
  ssh_ingress_rules = [
    {
      from_port   = 22
      to_port     = 22
      protocol    = "tcp"
      cidr_blocks = ["0.0.0.0/0"]
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
    Env  = "dev"
  }
}

module "ec2" {
  source                      = "../../modules/ec2"
  ami_id                      = "ami-0123456789abcdef0"
  instance_type               = "t3.micro"
  key_name                    = "ec2-dev"
  subnet_id                   = module.vpc.subnet_id
  security_group_ids          = [module.vpc.security_group_ids]
  associate_public_ip_address = true
  iam_instance_profile        = "ec2-s3-role"
  user_data                   = <<-EOF
                                    #!/bin/bash
                                    sudo apt update -y
                                    sudo apt install nginx -y
                                  EOF
  root_volume_size            = 20
  root_volume_type            = "gp3"
  tags = {
    Name = "Ec2-dev"
    Env  = "dev"
    Iac  = true
  }

  depends_on = [
    module.vpc
  ]
}

module "ebs" {
  source              = "../../modules/ebs"
  name                = "ebs_instance"
  availability_zone   = "us-east-1"
  size                = "20"
  ec2_id              = module.ec2.id
  enable_key_rotation = true

  tags = {
    Name = "ebs_instance-dev"
    Env  = "dev"
    Iac  = true
  }

  depends_on = [
    module.ec2
  ]
}

module "alb" {
  source                 = "../../modules/alb"
  alb_name               = "my-app-alb"
  alb_internal           = false
  alb_type               = "application"
  alb_security_group_ids = [module.vpc.security_group_ids]
  alb_subnet_ids         = [module.vpc.subnet_id]
  target_id              = module.ec2.id
  target_group_name      = "myapp-tg"
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
    Name = "alb-dev"
    Env  = "dev"
    Iac  = true
  }
  depends_on = [
    module.vpc,
    module.ec2
  ]
}

//TODO: Run terraform apply