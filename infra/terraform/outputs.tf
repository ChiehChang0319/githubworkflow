# 外部輸出 
output "salt_master_public_ip" {
  value = aws_instance.salt_master.public_ip
}

# local.salt_minions["minion01"] => 實例aws_instance.salt_minion["minion01"] , name="salt-minion-01" => instance.public_ip
output "salt_minion_public_ip" {
  value = {
    for key, instance in aws_instance.salt_minion :
    local.salt_minions[key].name => instance.public_ip
  }
}