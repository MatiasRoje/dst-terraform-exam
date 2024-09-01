resource "aws_launch_template" "web_server" {
  name                   = "mr-wordpress-lt"
  image_id               = data.aws_ami.amazon_linux.id
  instance_type          = "t2.micro"
  vpc_security_group_ids = [aws_security_group.web_sg.id]
  # user_data = file("wordpress_install.sh")
}

resource "aws_autoscaling_group" "web_asg" {
  name                = "mr-web-asg"
  desired_capacity    = 2
  max_size            = 2
  min_size            = 1
  vpc_zone_identifier = [aws_subnet.private_subnet_a.id, aws_subnet.private_subnet_b.id]

  launch_template {
    id      = aws_launch_template.web_server.id
    version = "$Latest"
  }

  tag {
    key                 = "Name"
    value               = "mr-web-server-instance"
    propagate_at_launch = true
  }
}