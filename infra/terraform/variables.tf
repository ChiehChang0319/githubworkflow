# 定義變量
# 區域 region
variable "aws_region" {
  description = "AWS region"
  type        = string

  default = "ap-southeast-1"
}

# 項目名
variable "project_name" {
  description = "Project name"
  type        = string

  default = "python-api"
}

# 環境
variable "environment" {
  description = "Environment"
  type        = string

  default = "production"
}


# 子網劃分
# VPC網段
variable "vpc_cidr" {
  description = "VPC CIDR"
  type        = string

  default = "10.0.0.0/16"
}

# Public Subnet 子網網段
variable "public_subnet_cidr" {
  description = "Public subnet CIDR"
  type        = string

  default = "10.0.1.0/24"
}

# SSH 可訪問網段
variable "allowed_ssh_cidrs" {
  description = "CIDR allowed to SSH"
  type        = list(string)

  default = []
}


# EC2實例類型
# Salt Master
variable "salt_master_instance_type" {
  type = string

  default = "t3.small"
}

# Salt Minion
variable "salt_minion_instance_type" {
  type = string

  default = "t3.micro"
}

# EC2的 SSH公鑰
variable "ssh_public_key" {
  description = "SSH public key"
  type        = string
  sensitive   = true
}

# AMI Owner ID (可選)
variable "ami_owner_id" {
  description = "AMI owner AWS account ID"
  type        = string
}