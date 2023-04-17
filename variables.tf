variable "transit_vpc_name" {
  description = "VPC Name of Transit Gateway"
  type        = string
}

variable "transit_vpc_id" {
  description = "VPC ID of Transit Gateway"
  type        = string
}

variable "transit_vpc_cidr" {
  description = "VPC cidr of Transit Gateway"
  type        = string
}

variable "transit_vpc_subnets" {
  description = "Subnet names from aviatrix_vpc resource."
  type        = list(string)
}

variable "transit_gw_name" {
  description = "Name of Transit Gateway"
  type        = string
}

variable "tgw_id" {
  description = "ID of AWS TGW."
  type        = string
}

variable "tgw_cidr" {
  description = "CIDR of AWS TGW."
  type        = string
}

locals {
  tgw_subnets = {
    zone-0 = {
      az   = regex("[a-z]{2}-[a-z]*-[0-9][a-z]", var.transit_vpc_subnets[0]),
      cidr = cidrsubnet(var.transit_vpc_cidr, 5, 14)
    },
    zone-1 = {
      az   = regex("[a-z]{2}-[a-z]*-[0-9][a-z]", var.transit_vpc_subnets[2]),
      cidr = cidrsubnet(var.transit_vpc_cidr, 5, 15)
    }
  }
}