resource "aws_key_pair" "Bastion" {
  key_name   = "Bastion"
  public_key = "${file("~/.ssh/id_rsa.pub")}"
}
