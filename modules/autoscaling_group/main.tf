resource "aws_launch_configuration" "launch_configuration" {
  name_prefix   = var.name
  image_id      = var.ami
  instance_type = var.instance_type
  security_groups = var.security_group_id
  associate_public_ip_address = var.associate_public_ip_address
  key_name = var.key_name

  ebs_block_device = {
      device_name = var.device_name
      volume_type = var.volume_type
      volume_size = var.volume_size
      iops        = var.volume_iops        
  }

  lifecycle {
    create_before_destroy = true
  }
}



resource "aws_autoscaling_group" "bar" {
  name                      = var.asg_name
  max_size                  = var.max_size
  min_size                  = var.min_size
  health_check_type         = var.health_check_type
  desired_capacity          = var.desired_capacity
  launch_configuration      = aws_launch_configuration.launch_configuration.name
  vpc_zone_identifier       = var.subnet_ids
  force_delete              = true
  target_group_arn = var.target_group_arns
  default_cooldown = 30
  health_check_grace_period = 300


  dynamic "tag" {
    for_each = var.tags
		
    content {
      key                 = tag.key
      value               = tag.value
      propagate_at_launch = true
    }
  }
  lifecycle {
    create_before_destroy = true
  }
}