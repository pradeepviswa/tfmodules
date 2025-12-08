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

output "public_ip" {
  value = aws_instance.vm[*].public_ip
}

resource "local_file" "ansible_inventory" {
  filename = "${path.module}/../configure_vm/inventory/hosts.ini"
  content = <<EOF
[webservers]
${join("\n", [
  for ip in aws_instance.vm[*].public_ip :
  "${ip} ansible_user=${var.ansible_user} ansible_ssh_private_key_file=${var.key_path}"
])}
EOF
}
