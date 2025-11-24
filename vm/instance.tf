resource "aws_instance" "vm" {
    ami = var.ami_id
    instance_type = var.instance_type
    key_name = var.key_name
    tags = {

        Name = var.vm_name
    }
}

output "public_ip" {
    value = aws_instance.vm.public_ip
}