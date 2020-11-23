module "webapp" {
  source = "/home/ec2-user/project/class4"
  region = "us-east-1"

  # max_size         = "1"
  # min_size         = "1"
  # desired_capacity = "1"
  # image_owner      = "679593333241"
  instance_type = "t2.micro"

  ami_id = "ami-04bf6dcdc9ab498ca"
}
