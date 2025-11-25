resource "aws_instance" "vm" {
  count         = var.count_vm
  ami           = var.ami_id
  instance_type = var.instance_type
  key_name      = var.key_name_vm

  tags = {
    Name = "${var.vm_name}-${count.index}"
  }
}

output "public_ip" {
  value = aws_instance.vm[*].public_ip
}

output "ansible_inventory" {
  value = <<EOF
[webservers]
%{ for ip in aws_instance.vm[*].public_ip ~}
${ip} ansible_user=ubuntu ansible_ssh_private_key_file={{key_path}}
%{ endfor ~}
EOF
}

