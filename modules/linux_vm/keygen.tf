resource "tls_private_key" "keygen" {
  algorithm   = "RSA"
rsa_bits = 2048

}
output "private_key" {
  value = tls_private_key.keygen.private_key_pem
}



