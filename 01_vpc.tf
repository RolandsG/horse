# Create a VPC
resource "aws_vpc" "horse_vpc" {
  cidr_block = var.vpc_cidr_block
  enable_dns_support = true
  enable_dns_hostnames = true
  tags = {
    Name = "${var.Module_name}.${var.aws_region}"
  }
}

resource "aws_security_group" "horse_sg" {
  name        = "${var.Module_name}.${var.aws_region}"
  description = "Allow SSH inbound on port 443" 
  vpc_id      = aws_vpc.horse_vpc.id

  ingress {
    description = "SSH from VPC"
    from_port   = 443
    to_port     = 443
    protocol    = "tcp"
    cidr_blocks = var.my_ip_address
  }

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }

  tags = {
    Name = "${var.Module_name}.${var.aws_region}"
  }
}

# Create gateway
resource "aws_internet_gateway" "horse_igw" {
  vpc_id = aws_vpc.horse_vpc.id
  tags = {
    Name = "${var.Module_name}.${var.aws_region}"
  }
}

#Create a Subnet
resource "aws_subnet" "horse_subnet_public" {
 vpc_id     = aws_vpc.horse_vpc.id
 cidr_block = var.subnet_public_cidr_block
 map_public_ip_on_launch = true
 availability_zone = var.availability_zone

  tags = {
    Name = "${var.Module_name}.${var.aws_region}.${var.availability_zone}.${var.public_subnet_type}"
  }
}

#Create public RT. routing table needs to be created in order to handle traffic.
resource "aws_route_table" "horse_rt_public" {
  vpc_id = aws_vpc.horse_vpc.id
  route {
    cidr_block = var.route_table_public_cidr_block
    gateway_id = aws_internet_gateway.horse_igw.id
  }
  tags = {
    Name = "${var.Module_name}.${var.route_table_public_name}"
  }
}

# Attach public RT. Routing table needs to be attached for traffic.
resource "aws_route_table_association" "horse_rt_assoc_public" {
  subnet_id      = aws_subnet.horse_subnet_public.id
  route_table_id = aws_route_table.horse_rt_public.id
}