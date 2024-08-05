data "aws_vpc" "main" {
  id = var.vpc_id
}

data "aws_route_tables" "private" {
  vpc_id = data.aws_vpc.main.id
  filter {
    name   = "tag:Name"
    values = ["project-rtb-private*"]
  }
}

resource "aws_vpn_gateway" "vpn_gw" {
  vpc_id = data.aws_vpc.main.id

  tags = {
    Name = "${var.name}"
  }
}

resource "aws_customer_gateway" "cgw" {
  for_each   = var.vpn_gw_addresses
  bgp_asn    = var.partner_asn
  ip_address = each.value.address
  type       = "ipsec.1"

  tags = {
    Name = "${var.name}-customer-gateway-${each.key}"
  }
}

resource "aws_vpn_connection" "vpn" {
  for_each                             = aws_customer_gateway.cgw
  transit_gateway_id                   = var.transit_gw
  customer_gateway_id                  = each.value.id
  type                                 = each.value.type
  tunnel1_ike_versions                 = ["ikev2"]
  tunnel1_phase1_encryption_algorithms = var.aws_vpn_configs.encryption_algorithms
  tunnel2_phase1_encryption_algorithms = var.aws_vpn_configs.encryption_algorithms
  tunnel1_phase1_integrity_algorithms  = var.aws_vpn_configs.integrity_algorithms
  tunnel2_phase1_integrity_algorithms  = var.aws_vpn_configs.integrity_algorithms
  tunnel1_phase1_dh_group_numbers      = var.aws_vpn_configs.dh_group_numbers
  tunnel2_phase1_dh_group_numbers      = var.aws_vpn_configs.dh_group_numbers
  tunnel1_phase2_encryption_algorithms = var.aws_vpn_configs.encryption_algorithms
  tunnel2_phase2_encryption_algorithms = var.aws_vpn_configs.encryption_algorithms
  tunnel1_phase2_integrity_algorithms  = var.aws_vpn_configs.integrity_algorithms
  tunnel2_phase2_integrity_algorithms  = var.aws_vpn_configs.integrity_algorithms
  tunnel1_phase2_dh_group_numbers      = var.aws_vpn_configs.dh_group_numbers
  tunnel2_phase2_dh_group_numbers      = var.aws_vpn_configs.dh_group_numbers

  tags = {
    Name = "${var.name}-${each.key}"
  }
}

resource "aws_security_group" "allow_partner_vpn" {
  name        = var.name
  description = "${var.name} allow all traffic"
  vpc_id      = data.aws_vpc.main.id

  ingress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = [var.vpn_network_cidr]
  }

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }

  tags = {
    Name = var.name
  }
}