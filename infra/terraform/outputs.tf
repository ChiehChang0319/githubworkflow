# 外部輸出 
output "salt_master_public_ip" {
  value = aws_instance.salt_master.public_ip
}

output "salt_minion_public_ip" {
  value = aws_instance.salt_minion.public_ip
}