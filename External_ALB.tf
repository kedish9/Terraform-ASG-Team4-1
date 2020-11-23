# resource "aws_lb" "External_ALB" {
#   name               = "test-lb-tf"
#   internal           = false
#   load_balancer_type = "application"
#   security_groups    = ["${aws_security_group.WP_SG.id}"]
#   availability_zones = [
#     "${var.region}a",
#     "${var.region}b",
#     "${var.region}c",
#   ]
#   //subnets            = aws_subnet.public.*.id

#   # listener {
#   #   instance_port     = 80
#   #   instance_protocol = "http"
#   #   lb_port           = 80
#   #   lb_protocol       = "http"
#   # }
#   # health_check {
#   #   healthy_threshold   = 2
#   #   unhealthy_threshold = 2
#   #   timeout             = 3
#   #   target              = "HTTP:80/"
#   #   interval            = 30
#   # }

#   enable_deletion_protection = true


#   tags = {
#     Environment = "production"
#   }
# }

resource "aws_elb" "External_ALB" {
  name = "ExternalALB"
  
  security_groups = [
   "${aws_security_group.WP_SG.id}",
  ]

  availability_zones = [
    "${var.region}a",
    "${var.region}b",
    "${var.region}c",
  ]

  listener {
    instance_port     = 80
    instance_protocol = "http"
    lb_port           = 80
    lb_protocol       = "http"
  }

  health_check {
    healthy_threshold   = 2
    unhealthy_threshold = 2
    timeout             = 3
    target              = "HTTP:80/"
    interval            = 30
  }

  cross_zone_load_balancing   = true
  idle_timeout                = 400
  connection_draining         = true
  connection_draining_timeout = 400

  tags = {
    Name = "foobar-terraform-elbs"
  }
}


resource "aws_autoscaling_attachment" "asg_attachment_bar" {
  autoscaling_group_name = "${aws_autoscaling_group.WP.id}"
  elb = "${aws_elb.External_ALB.id}"
}