data "template_file" "WP_Template" {
    template = "${file("${path.module}/wordpress.sh")}"
}




resource "aws_launch_template" "WP" {
  name_prefix          = "WP_template"
  image_id             = "${var.ami_id}"
  instance_type        = "${var.instance_type}"
  security_group_names = ["${aws_security_group.WP_SG.name}"]
  key_name             = "${aws_key_pair.Bastion.key_name}"
  user_data = "${base64encode(data.template_file.WP_Template.rendered)}"
  
}
