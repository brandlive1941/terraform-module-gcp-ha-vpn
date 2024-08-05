output "vpn_configuration" {
  description = "AWS VPN Configuration for use downstream in VPN Configuration"
  value = {
    "0" = {
      tunnel_address        = aws_vpn_connection.vpn[0].tunnel1_address
      vgw_inside_address    = aws_vpn_connection.vpn[0].tunnel1_vgw_inside_address
      asn                   = aws_vpn_connection.vpn[0].tunnel1_bgp_asn
      cgw_inside_address    = "${aws_vpn_connection.vpn[0].tunnel1_cgw_inside_address}/30"
      vpn_gateway_interface = 0
    },
    "1" = {
      tunnel_address        = aws_vpn_connection.vpn[0].tunnel2_address
      vgw_inside_address    = aws_vpn_connection.vpn[0].tunnel2_vgw_inside_address
      asn                   = aws_vpn_connection.vpn[0].tunnel2_bgp_asn
      cgw_inside_address    = "${aws_vpn_connection.vpn[0].tunnel2_cgw_inside_address}/30"
      vpn_gateway_interface = 0
    },
    "2" = {
      tunnel_address        = aws_vpn_connection.vpn[1].tunnel1_address
      vgw_inside_address    = aws_vpn_connection.vpn[1].tunnel1_vgw_inside_address
      asn                   = aws_vpn_connection.vpn[1].tunnel1_bgp_asn
      cgw_inside_address    = "${aws_vpn_connection.vpn[1].tunnel1_cgw_inside_address}/30"
      vpn_gateway_interface = 1
    },
    "3" = {
      tunnel_address        = aws_vpn_connection.vpn[1].tunnel2_address
      vgw_inside_address    = aws_vpn_connection.vpn[1].tunnel2_vgw_inside_address
      asn                   = aws_vpn_connection.vpn[1].tunnel2_bgp_asn
      cgw_inside_address    = "${aws_vpn_connection.vpn[1].tunnel2_cgw_inside_address}/30"
      vpn_gateway_interface = 1
    }
  }
}
