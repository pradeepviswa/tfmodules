# tfmodules

This repository demonstrates how to use Terraform modules for creating SSH keys, provisioning EC2 instances, and generating an Ansible inventory file automatically.

---

## 📌 Key File Module

```hcl
module "key_file" {
  source   = "git::https://github.com/pradeepviswa/tfmodules.git//key_file?ref=main"
  key_name = var.key_name
}
```

---

## 📌 VM Module

```hcl
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
```

---

## 📌 Output – Public IPs

```hcl
output "public_ips" {
  value = module.vm.public_ips
}
```

---

## 📌 Generate Ansible Inventory File

```hcl
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
```

---

## 📌 Example Variables for VM Module

```hcl
ami_id        = "ami-0ecb62995f68bb549"
instance_type = "t3.micro"
vm_name       = "MyServer"
count_vm      = 1
allowed_ports = [22, 80, 8080, 3000]
key_name      = "key_1"
key_path      = "~/.ssh/key_1.pem"
ansible_user  = "ubuntu"
```

---

## 🚀 Deployment Steps

### 1️⃣ Configure AWS Credentials

```bash
export AWS_ACCESS_KEY_ID=""
export AWS_SECRET_ACCESS_KEY=""
```

### 2️⃣ Apply Terraform to Create VM(s)

```bash
cd create_vm
terraform apply --var-file=env/dev.tfvars -auto-approve
```

### 3️⃣ Verify Ansible Inventory

```bash
cd ../configure_vm
ansible -i inventory/hosts.ini all --list-hosts
```

### 4️⃣ Ping Servers via Ansible

```bash
ansible -i inventory/hosts.ini all -m ping
```
