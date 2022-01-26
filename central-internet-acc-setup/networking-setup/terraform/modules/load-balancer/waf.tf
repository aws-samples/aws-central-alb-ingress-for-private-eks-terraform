resource "aws_wafv2_web_acl" "internet-ingress-alb" {
  name        = "internet-ingress-alb"
  description = "WAF Web ACL for Internet Ingress ALB"
  scope       = "REGIONAL"

  default_action {
    allow {}
  }

  rule {
    name     = "AWS-AWSManagedRulesCommonRuleSet"
    priority = 1
    override_action {
      count {}
    }

    statement {
      managed_rule_group_statement {
        name        = "AWSManagedRulesCommonRuleSet"
        vendor_name = "AWS"

        # excluded_rule {
        #   name = "SizeRestrictions_QUERYSTRING"
        # }

        # excluded_rule {
        #   name = "NoUserAgent_HEADER"
        # }
      }
    }

    visibility_config {
      cloudwatch_metrics_enabled = true
      metric_name                = "AWS-AWSManagedRulesCommonRuleSet"
      sampled_requests_enabled   = true
    }
  }

  tags = {
    Name       = "internet-ingress-alb-web-acl"
  }

  visibility_config {
    cloudwatch_metrics_enabled = true
    metric_name                = "AWS-AWSManagedRulesCommonRuleSet"
    sampled_requests_enabled   = true
  }
}

resource "aws_wafv2_web_acl_association" "internet-ingress-alb" {
  resource_arn = aws_lb.internet-ingress-alb.arn
  web_acl_arn  = aws_wafv2_web_acl.internet-ingress-alb.arn
}
