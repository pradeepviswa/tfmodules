resource "aws_instance" "vm" {
  count                  = var.count_vm
  ami                    = var.ami_id
  instance_type          = var.instance_type
  key_name               = aws_key_pair.generated_key.key_name
  vpc_security_group_ids = [aws_security_group.my_sg.id]

  tags = {
    Name = "${var.vm_name}-${count.index}"
  }
}

output "public_ips" {
  value = aws_instance.vm[*].public_ip
}

output "ansible_user" {
  value = var.ansible_user
}

output "key_path" {
  value = var.key_path
}


