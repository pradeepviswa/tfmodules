resource "aws_instance" "new_instance" {
    ami = var.ami_id
    instance_type = var.instance_type
    key_name = var.key_name
    tags = {

        Name = var.vm_name
    }
}

