resource "aws_lb_target_group" "target_group" {
  provider    = aws.network-role
  name        = "${var.name}-target-group"
  port        = "80"
  protocol    = "HTTPS"
  target_type = "ip"
  vpc_id      = var.vpc_id

  health_check {
    protocol = "HTTPS"
    port     = "80"
    path     = "/"
  }
}

resource "aws_alb_target_group_attachment" "targets_attachement" {
  provider         = aws.network-role
  count            = 3
  target_group_arn = aws_lb_target_group.target_group.arn
  target_id        = var.team_endpoint_private_ips[count.index]
}

resource "aws_lb_listener_rule" "alb_listener_rule" {
  provider     = aws.network-role
  listener_arn = var.listener_arn

  action {
    type             = "forward"
    target_group_arn = aws_lb_target_group.target_group.arn
  }

 condition {
   path_pattern {
     values = ["/internet"]
   }
  }
}

/*resource "aws_route53_record" "team_wildcard" {
  provider = aws.network-role
  zone_id  = var.dns_zone_id
  name     = "*.${var.team_name}.${var.subdomain}"
  type     = "A"

  alias {
    name                   = var.alb_dns_name
    zone_id                = var.alb_dns_zone_id
    evaluate_target_health = true
  }
}*/
