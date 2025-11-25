resource "tls_private_key" "ssh_key" {
  algorithm = "RSA"
  rsa_bits  = 4096

  lifecycle {
    prevent_destroy = true
  }
}

resource "aws_key_pair" "generated_key" {
  key_name   = var.key_name
  public_key = tls_private_key.ssh_key.public_key_openssh

  lifecycle {
    prevent_destroy = true
  }
}

resource "local_file" "private_key_pem" {
  filename = "${path.module}/${var.key_name}.pem"
  content  = tls_private_key.ssh_key.private_key_pem
  file_permission = "0600"

  lifecycle {
    prevent_destroy = true
  }
}

output "key_pair_name" {
  value = aws_key_pair.generated_key.key_name
}
