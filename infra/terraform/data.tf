# 查詢外部資源AMI ubuntu鏡像的數據
data "aws_ami" "ubuntu" {

  most_recent = true

  owners = [var.ami_owner_id]

  filter {
    name   = "name"
    values = ["ubuntu/images/hvm-ssd-gp3/ubuntu-noble-24.04-amd64-server-*"]
  }

  filter {
    name   = "architecture"
    values = ["x86_64"]
  }

  filter {
    name   = "virtualization-type"
    values = ["hvm"]
  }

}

# 使用 "archive_file" 組建來打包壓縮包
data "archive_file" "salt_states" {
  type        = "tar.gz"
  source_dir  = "${path.module}/../../salt/states"
  output_path = "${path.module}/salt-states.tar.gz"
}