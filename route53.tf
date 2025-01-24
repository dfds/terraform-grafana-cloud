data "aws_route53_zone" "this" {
  provider = aws.route53
  count    = var.hosted_zone_name != null ? 1 : 0

  name = var.hosted_zone_name

  tags = var.tags
}

resource "aws_route53_record" "this" {
  provider = aws.route53
  count    = var.hosted_zone_name != null ? 1 : 0

  zone_id = data.aws_route53_zone.this[count.index].zone_id
  name    = var.route53_record_name
  type    = "CNAME"
  ttl     = 300
  records = ["${var.slug}.grafana.net"]
}
