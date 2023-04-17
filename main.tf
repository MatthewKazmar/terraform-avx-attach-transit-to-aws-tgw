# Add tgw subnets to Aviatrix Transit VPC
resource "aws_subnet" "this" {
  for_each = local.tgw_subnets

  vpc_id            = var.transit_vpc_id
  cidr_block        = each.value["cidr"]
  availability_zone = each.value["az"]

  tags = {
    Name = "${var.transit_vpc_name}-tgw-${each.key}"
  }
}

#Transit VPC always goes to default.
resource "aws_ec2_transit_gateway_vpc_attachment" "this" {
  subnet_ids         = aws_subnet.this[*].id
  vpc_id             = var.transit_vpc_id
  transit_gateway_id = var.tgw_id
  #transit_gateway_default_route_table_association = false
  #transit_gateway_default_route_table_propagation = false

  tags = {
    Name = "${var.transit_vpc_name}-attachment"
  }
}

data "aws_route_tables" "this" {
  vpc_id = var.transit_vpc_id
  filter {
    name   = "tag:${var.transit_vpc_name}"
    values = ["Public-rtb"]
  }
}

resource "aws_route" "this" {
  route_table_id         = data.aws_route_tables.this.ids[0]
  destination_cidr_block = var.tgw_cidr
  transit_gateway_id     = var.tgw_id
}