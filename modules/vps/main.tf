resource "aws_vpc" "main" {
  cidr_block = var.vpc_cidr_block
  tags = var.vpc_tags
}

resource "aws_subnet" "public" {
  vpc_id  = aws_vpc.main.id
  cidr_block = var.subnet_cidr_block 
  availability_zone  = var.subnet_availability_zone
  map_public_ip_on_launch = var.subnet_map_public_ip_on_launch

  tags = var.subnet_tags

  depends_on = [
    aws_vpc.main
  ]
}

resource "aws_internet_gateway" "gateway" {
  vpc_id  = aws_vpc.main.id

  tags = var.gateway_tags

  depends_on = [
    aws_vpc.main
  ]
}


resource "aws_route_table" "public" {
  vpc_id = aws_vpc.main.id

  route {
    cidr_block = var.route_cidr_block
    gateway_id = aws_internet_gateway.gateway.id
  }

  tags = var.route_tags

   depends_on = [
    aws_vpc.main,
    aws_internet_gateway.gateway
   ]
}


resource "aws_route_table_association" "route" {
  subnet_id      = aws_subnet.public.id
  route_table_id = aws_route_table.public.id

  depends_on = [
    aws_subnet.public,
    aws_route_table.public
  ]
}

resource "aws_security_group" "ssh" {
  name = var.ssh_name
  description = var.ssh_description
  vpc_id = aws_vpc.main.id

  dynamic "ingress" {
    for_each = var.ssh_ingress_rules
    content {
      from_port   = ingress.value.from_port
      to_port     = ingress.value.to_port
      protocol    = ingress.value.protocol
      cidr_blocks = ingress.value.cidr_blocks
    }
  }

  
  dynamic "egress" {
    for_each = var.egress_rules
    content {
      from_port   = egress.value.from_port
      to_port     = egress.value.to_port
      protocol    = egress.value.protocol
      cidr_blocks = egress.value.cidr_blocks
    }
  }

  tags = var.ssh_tags

  depends_on = [
    aws_vpc.main,
   ]
}