output "alb_id" {
  value = aws_lb.internet-ingress-alb.id
}

output "alb_arn" {
  value = aws_lb.internet-ingress-alb.arn
}

output "alb_dns_name" {
  value = aws_lb.internet-ingress-alb.dns_name
}

output "alb_dns_zone_id" {
  value = aws_lb.internet-ingress-alb.zone_id
}

output "aws_security_group_id" {
  value = aws_security_group.internet-ingress-alb-sg.id
}

output "alb_https_listener_arn" {
  value = aws_lb_listener.https.arn
}
