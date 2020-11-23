resource "aws_autoscaling_group" "WP" {
  name                 = "WP"
  //launch_configuration = "${aws_launch_template.WP.name}"
  # health_check_grace_period = 300
  # health_check_type         = "ELB"

  launch_template {
    id      = "${aws_launch_template.WP.id}"
    
  }

  availability_zones = [
	"${var.region}a",
	"${var.region}b",
	"${var.region}c",
  ]
  desired_capacity     = 1
  min_size             = 1
  max_size             = 4
lifecycle {
    create_before_destroy = true
  }
}

resource "aws_autoscaling_policy" "Scaling_Policy_WP" {
  name                   = "Scaling_Policy_WP"
  # scaling_adjustment     = 1
  # adjustment_type        = "ChangeInCapacity"
  # cooldown               = 200
  policy_type = "TargetTrackingScaling"
  autoscaling_group_name = "${aws_autoscaling_group.WP.name}"

  target_tracking_configuration {
    predefined_metric_specification {
      predefined_metric_type = "ASGAverageCPUUtilization"
    }

    target_value = 40.0
  }
}