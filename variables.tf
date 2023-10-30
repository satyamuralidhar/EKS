variable "region" {}

#Network

variable "vpc_name" {}
variable "vpc_cidr_block" {}
variable "subnets_name" {}
variable "public_subnet_type" { default = false }
variable "private_subnet_type" { default = false }
variable "cidr_newbits" {}
variable "internet_gateway_name" {}
variable "route_table_name" {}
variable "nat_gateway_name" {}
variable "nat_subnets_prefix" {}
