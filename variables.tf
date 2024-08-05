variable "name" {
  description = "name"
  type        = string
}

variable "vpc_id" {
  description = "ID of the VPC you wish to connect from"
  type        = string
}

variable "vpn_network_cidr" {
  description = "CIDR of the network you wish to connect to"
  type        = string
}

variable "transit_gw" {
  description = "Transit Gateway ID"
  type        = string
}

variable "partner_asn" {
  description = "partner ASN"
  type        = string
}

variable "aws_vpn_configs" {
  type        = map(any)
  description = "AWS Tunnels Configs for aws_vpn_connection. This addresses this [known issue](https://cloud.google.com/network-connectivity/docs/vpn/how-to/creating-ha-vpn)."
  default = {
    encryption_algorithms = ["AES256"]
    integrity_algorithms  = ["SHA2-256"]
    dh_group_numbers      = ["18"]
  }
}

variable "vpn_gw_addresses" {
  type        = map(any)
  description = "Partner VPN Gateway Addresses"
  default = {
    "0" = {
      "address" = ""
    }
    "1" = {
      "address" = ""
    }
  }
}