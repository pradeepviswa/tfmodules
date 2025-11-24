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
