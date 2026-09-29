terraform {
  # 決定 Terraform CLI version
  required_version = ">= 1.9.0"

  # 決定 Provider version
  required_providers {

    aws = {
      source  = "hashicorp/aws"
      version = "~> 6.0"
    }

    # 使用 archive provider, terraform官方插件來打包壓縮包
    archive = {
      source  = "hashicorp/archive"
      version = "~> 2.7"
    }

  }
}