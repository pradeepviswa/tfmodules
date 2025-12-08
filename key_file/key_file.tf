resource "tls_private_key" "ssh_key" {
  algorithm = "RSA"
  rsa_bits  = 4096

  lifecycle {
    prevent_destroy = false
  }
}

resource "aws_key_pair" "generated_key" {
  key_name   = var.key_name
  public_key = tls_private_key.ssh_key.public_key_openssh
}

resource "local_file" "private_key_pem" {
  filename        = "${path.root}/${var.key_name}.pem"
  content         = tls_private_key.ssh_key.private_key_pem
  file_permission = "0600"

  lifecycle {
    prevent_destroy = false
  }
}

output "key_pair_name" {
  value = aws_key_pair.generated_key.key_name
}
