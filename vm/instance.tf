resource "aws_instance" "vm" {
  count         = var.vm_count
  ami           = var.ami_id
  instance_type = var.instance_type
  key_name      = var.key_name

  tags = {
    Name = "${var.vm_name}-${count.index}"
  }
}

output "public_ip" {
  value = aws_instance.vm[*].public_ip
}
