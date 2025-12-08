# tfmodules

This repository demonstrates how to use Terraform modules for creating SSH keys, provisioning EC2 instances, and generating an Ansible inventory file automatically.

---

## 📌 Key File Module

```hcl
module "key_file" {
  source   = "git::https://github.com/pradeepviswa/tfmodules.git//key_file?ref=main"
  key_name = var.key_name
}

module "vm" {
  source        = "git::https://github.com/pradeepviswa/tfmodules.git//vm?ref=main"
  ami_id        = var.ami_id
  instance_type = var.instance_type
  vm_name       = var.vm_name
  key_name      = var.key_name
  key_path      = var.key_path
  count_vm      = var.count_vm
  allowed_ports = var.allowed_ports
  ansible_user  = var.ansible_user
}

output "public_ips" {
  value = module.vm.public_ips
}



resource "local_file" "ansible_inventory" {
  filename = "${path.root}/../configure_vm/inventory/hosts.ini"
  content  = <<EOF
[webservers]
${join("\n", [
  for ip in module.vm.public_ips :
  "${ip} ansible_user=${module.vm.ansible_user} ansible_ssh_private_key_file=${module.vm.key_path}"
])}
EOF
}



