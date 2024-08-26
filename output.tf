output "ec2_public_ip" {
  value = aws_instance.harish[*].public_ip
}

output "ec2_private_ip" {
  value = aws_instance.harish[*].private_ip
}

output "instance_id" {
  value = aws_instance.harish[*].id
}

