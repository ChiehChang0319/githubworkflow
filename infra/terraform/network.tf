# 創建VPC
resource "aws_vpc" "main" {

  cidr_block = var.vpc_cidr

  # 開啟VPC DNS
  enable_dns_hostnames = true
  enable_dns_support   = true

  tags = {
    Name = "${local.name_prefix}-vpc" # ${var.project_name}-${var.environment}-vpc
  }
}

# 創建IGW 對外訪問
resource "aws_internet_gateway" "main" {
  vpc_id = aws_vpc.main.id # 透過 vpc_id 去Attach VPC

  tags = {
    Name = "${local.name_prefix}-igw" # ${var.project_name}-${var.environment}-igw
  }
}

# 創建 Public Subnet
resource "aws_subnet" "public" {
  vpc_id = aws_vpc.main.id # 透過 vpc_id 去Attach VPC

  cidr_block = var.public_subnet_cidr

  availability_zone = "${var.aws_region}a"

  map_public_ip_on_launch = true # 開啟自動分配public ip

  tags = {
    Name = "${local.name_prefix}-public-subnet" # ${var.project_name}-${var.environment}-public-subnet
  }
}


# 創建Public路由表
resource "aws_route_table" "public" {
  vpc_id = aws_vpc.main.id # 透過 vpc_id 去Attach VPC main

  # 路由 0.0.0.0/0 -> IGW
  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = aws_internet_gateway.main.id
  }

  tags = {
    Name = "${local.name_prefix}-public-route-table" # ${var.project_name}-${var.environment}-public-route-table
  }
}

# 需要 aws_route_table_association 來關聯 Public subnet 和 Public路由表 
resource "aws_route_table_association" "public" {
  subnet_id = aws_subnet.public.id #  資源aws_route_table_association 透過 subnet_id 

  route_table_id = aws_route_table.public.id # 資源aws_route_table_association 透過 route_table_id
}


