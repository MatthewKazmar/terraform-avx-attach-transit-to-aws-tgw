# terraform-avx-attach-transit-vpc-to-aws-tgw

Attach an Aviatrix Transit Gateway VPC to a TGW. Designed to be used with either:
- https://registry.terraform.io/modules/terraform-aviatrix-modules/mc-transit/aviatrix/latest
- https://registry.terraform.io/modules/terraform-aviatrix-modules/backbone/aviatrix/latest

There is also my AWS Transit Gateway module that could be used.
- https://github.com/MatthewKazmar/terraform-aws-tgw

Example use:
```
module "aws_tgw_vpc_attachment_east" {
  providers = {
    aws = aws.east
  }

  source = "github.com/MatthewKazmar/terraform-avx-attach-transit-vpc-to-aws-tgw"

  transit_vpc_name    = module.avx_backbone.transit["aws_east"]["vpc"].name
  transit_vpc_id      = module.avx_backbone.transit["aws_east"]["vpc"].vpc_id
  transit_vpc_cidr    = module.avx_backbone.transit["aws_east"]["vpc"].cidr
  transit_vpc_subnets = module.avx_backbone.transit["aws_east"]["vpc"].subnets[*].name
  transit_gw_name     = module.avx_backbone.transit["aws_east"]["transit_gateway"].gw_name
  tgw_id              = module.aws_tgw_east.tgw.id
  tgw_cidr            = tolist(module.aws_tgw_east.tgw.transit_gateway_cidr_blocks)[0]
}
```
