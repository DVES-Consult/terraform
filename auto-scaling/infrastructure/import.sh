terraform import aws_lb.api_enviar_email_1 arn:aws:elasticloadbalancing:us-east-1:285552379206:loadbalancer/app/api-enviar-email-1/f44597718c0568d2
terraform import aws_lb.site_web_1 arn:aws:elasticloadbalancing:us-east-1:285552379206:loadbalancer/app/site-web-1/a039a669029be852

terraform import aws_lb_target_group.api_enviar_email_1 arn:aws:elasticloadbalancing:us-east-1:285552379206:targetgroup/api-email/9609979418a809b3
terraform import aws_lb_target_group.site_web_1 arn:aws:elasticloadbalancing:us-east-1:285552379206:targetgroup/site-web-1/079ca0b5f9a9ecb3

terraform import aws_lb_listener.api_enviar_email_1 arn:aws:elasticloadbalancing:us-east-1:285552379206:listener/app/api-enviar-email-1/f44597718c0568d2/0d323f1b2ade9f65
terraform import aws_lb_listener.site_web_1 arn:aws:elasticloadbalancing:us-east-1:285552379206:listener/app/site-web-1/a039a669029be852/59b57b24685ebebf

terraform import aws_route53_record.dves_cloud Z03778861RLKAHMOIT56K_dves.cloud_A
terraform import aws_route53_record.api_dves_cloud Z03778861RLKAHMOIT56K_api_A

