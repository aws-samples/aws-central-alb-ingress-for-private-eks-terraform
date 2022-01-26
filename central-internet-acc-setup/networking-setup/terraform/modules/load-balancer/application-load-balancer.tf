resource "aws_lb" "internet-ingress-alb" {
  name                       = "internet-ingress-alb"
  internal                   = false
  load_balancer_type         = "application"
  security_groups            = [aws_security_group.internet-ingress-alb-sg.id]
  subnets                    = var.public_ingress_subnet_ids
  enable_deletion_protection = false

  tags = {
    Name       = "internet-ingress-alb"

  }
}

resource "aws_security_group" "internet-ingress-alb-sg" {
  name        = "internet-ingress-alb-sg"
  description = "Allow TLS inbound traffic"
  vpc_id      = var.vpc_id

  # Add ingress block to allow traffic from the internet
  ingress {
    description      = "Global allow HTTPS from the Internet"
    from_port        = 80
    to_port          = 80
    protocol         = "tcp"
    cidr_blocks      = ["0.0.0.0/0"]
  }

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }

  tags = {
    Name       = "internet-ingress-alb-sg"

  }
}

resource "aws_lb_listener" "https" {
  load_balancer_arn = aws_lb.internet-ingress-alb.arn
  port              = "80"
  protocol          = "HTTP"

  default_action {
    type = "fixed-response"

    fixed_response {
      content_type = "text/plain"
      message_body = "Dead end!"
      status_code  = "404"
    }
  }
}