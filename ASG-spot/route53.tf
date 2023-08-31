resource "aws_route53_zone" "dves_cloud" {
  name = "dves.cloud"
}

resource "aws_route53_record" "dves_cloud" {
  zone_id = aws_route53_zone.dves_cloud.zone_id
  name    = "dves.cloud"
  type    = "A"
  alias {
    evaluate_target_health = true
    name                   = "dualstack.${aws_lb.site_web_1.dns_name}"
    zone_id                = aws_lb.site_web_1.zone_id
  }
}

# resource "aws_route53_record" "api_dves_cloud" {
#   zone_id = aws_route53_zone.dves_cloud.zone_id
#   name    = "api"
#   type    = "A"
#   alias {
#     evaluate_target_health = true
#     name                   = "dualstack.${aws_lb.api_enviar_email_1.dns_name}"
#     zone_id                = aws_lb.api_enviar_email_1.zone_id
#   }
# }