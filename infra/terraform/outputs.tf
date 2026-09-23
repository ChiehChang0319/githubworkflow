# 外部輸出 
output "server_public_ip" {
  value = aws_instance.app.public_ip
}

output "server_public_dns" {
  value = aws_instance.app.public_dns
}