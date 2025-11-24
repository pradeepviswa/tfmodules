resource aws_instance "new_instance" {
    for_each = var.instances

    ami           = each.value.ami_id
    instance_type = each.value.instance_type
    tags = {
        Name        = "${each.key}-${each.value.vm_name}"
        Environment = each.value.env
    }
}

