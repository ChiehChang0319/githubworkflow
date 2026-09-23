# 設置安全組
# Salt-Maser 
resource "aws_security_group" "salt_master" {
  name   = "${local.name_prefix}-master-security-group" # ${var.project_name}-${var.environment}-master-security-group
  vpc_id = aws_vpc.main.id

  # 入站
  # SSH
  ingress {
    from_port = 22
    to_port   = 22
    protocol  = "tcp"

    cidr_blocks = var.allowed_ssh_cidrs
  }

  # Salt Publish Port 
  ingress {
    from_port = 4505
    to_port   = 4505
    protocol  = "tcp"

    security_groups = [
      aws_security_group.salt_minion.id
    ]
  }

  # Salt Return Port 
  ingress {
    from_port = 4506
    to_port   = 4506
    protocol  = "tcp"

    security_groups = [
      aws_security_group.salt_minion.id
    ]
  }

  # 出站
  egress {
    from_port = 0
    to_port   = 0
    protocol  = "-1"

    cidr_blocks = [
      "0.0.0.0/0"
    ]
  }

  tags = {
    Name = "${local.name_prefix}-master-security-group" # ${var.project_name}-${var.environment}-master-security-group
  }
}

#Salt-Minion
resource "aws_security_group" "salt_minion" {
  name   = "${local.name_prefix}-minion-security-group" # ${var.project_name}-${var.environment}-minion-security-group
  vpc_id = aws_vpc.main.id                              # 透過 vpc_id 去Attach VPC main 

  # 入站
  # SSH
  ingress {
    from_port = 22
    to_port   = 22
    protocol  = "tcp"

    cidr_blocks = var.allowed_ssh_cidrs
  }

  # 出站
  egress {
    from_port = 0
    to_port   = 0
    protocol  = "-1"

    cidr_blocks = [
      "0.0.0.0/0"
    ]
  }

  tags = {
    Name = "${local.name_prefix}-minion-sg"
  }
}