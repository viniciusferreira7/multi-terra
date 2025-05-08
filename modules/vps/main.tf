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