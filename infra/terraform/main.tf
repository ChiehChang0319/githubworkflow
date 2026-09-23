# SSH 公鑰
resource "aws_key_pair" "deploy" {
  key_name   = "${local.name_prefix}-key"
  public_key = var.ssh_public_key

  tags = local.common_tags
}

# 創建EC2實例
# salt-master
resource "aws_instance" "salt_master" {

  ami           = data.aws_ami.ubuntu.id        # AMI鏡像ID
  instance_type = var.salt_master_instance_type # Master實例type
  subnet_id     = aws_subnet.public.id          # public subnet id 子網ID (同內網網段)

  vpc_security_group_ids = [
    aws_security_group.salt_master.id # master的安全組
  ]

  # cloud-init初始化, 透過user_data傳入 
  user_data = templatefile(
    "${path.module}/cloud-init.yaml", # 用cloud-init初始化安裝salt和配置master/minion
    {
      # cloud-init傳參,role 用來判斷安裝 master 或 minion
      role = "master"

      # Salt 官方安裝腳本
      #bootstrap_script = file(local.bootstrap_salt_script)

      # salt_master_config 配置文件 (同一個 master)
      salt_config = file(local.salt_master_config)
    }
  )
  # AWS tags 
  tags = {
    Name = "${local.name_prefix}-salt-master"
    Role = "salt-master"
  }
}

# salt-minion
resource "aws_instance" "salt_minion" {
  for_each = local.salt_minions # Salt Minion 另外拉出來傳參管理

  ami           = data.aws_ami.ubuntu.id        # AMI鏡像ID
  instance_type = var.salt_minion_instance_type # Minion實例type
  subnet_id     = aws_subnet.public.id          # public subnet id 子網ID (同內網網段)

  vpc_security_group_ids = [
    aws_security_group.salt_minion.id # minion安全組
  ]

  # cloud-init初始化, 透過user_data傳入
  user_data = templatefile(
    "${path.module}/cloud-init.yaml",
    {
      # cloud-init傳參,role用來判斷安裝master或minion
      role = "minion"

      # Salt 官方安裝腳本
      #bootstrap_script = file(local.bootstrap_salt_script)

      # # salt_minion_config 配置文件 (Minion採用.tftpl模板進行動態render)
      salt_minion_config = templatefile(
        local.salt_minion_config,
        {
          salt_master_private_ip = aws_instance.salt_master.private_ip
          minion_id              = each.value.name
        }
      )

    }
  )
  # AWS tags
  tags = {
    Name = "${local.name_prefix}-${each.value.name}"
    Role = "salt-minion"
  }
}
