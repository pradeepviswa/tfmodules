resource aws_instance "new_instance" {
    for_each = var.instances

    ami           = each.value.ami_id
    instance_type = each.value.instance_type
    key_name = each.value.key_name
    tags = {
        Name        = "${each.key}-${each.value.vm_name}"
    }
}

output "public_ips" {
    value = { for k, v in aws_instance.new_instance : k => v.public_ip }
}