data "template_file" "DB_Template" {
    template = "${file("${path.module}/MariaDB.sh")}"
}



resource "aws_launch_template" "DB" {
  name_prefix          = "DB_template"
  image_id             = "${data.aws_ami.centos.id}"
  instance_type        = "${var.instance_type}"
  security_group_names = ["${aws_security_group.SG_DB.name}"]
  key_name             = "${aws_key_pair.Bastion.key_name}"
  user_data = "${base64encode(data.template_file.DB_Template.rendered)}"
  
}
