output "attachment" {
  description = "The AWS TGW attachment resource."
  value       = aws_ec2_transit_gateway_vpc_attachment.this
}