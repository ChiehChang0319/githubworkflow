# 設置 Name / Tag
locals {

  name_prefix = "${var.project_name}-${var.environment}"

  common_tags = {
    Project     = var.project_name
    Environment = var.environment
    ManagedBy   = "Terraform"
  }

  # Salt Minion 另外拉出來傳參管理
  salt_minions = {
    minion01 = {
      name = "salt-minion-01"
    }

    minion02 = {
      name = "salt-minion-02"
    }

    minion03 = {
      name = "salt-minion-03"
    }

  }


  # salt_master_config 配置文件位置 (同一個 master)
  salt_master_config = "${path.module}/../../salt/master-config/bootstrap.conf"

  # salt_minion_config 配置文件位置 (.tftpl模板進行動態render)
  salt_minion_config = "${path.module}/../../salt/minion-config/bootstrap.conf.tftpl"

}