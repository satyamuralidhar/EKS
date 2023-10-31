provider "aws" {
  region = "ap-south-1"
}

module "network_test" {
    source = "../../modules/network"
    vpc_name              = var.vpc_name
    vpc_cidr_block        = var.vpc_cidr_block
    subnets_name          = var.subnets_name
    public_subnet_type    = var.public_subnet_type
    private_subnet_type   = var.private_subnet_type
    cidr_newbits          = var.cidr_newbits
    internet_gateway_name = var.internet_gateway_name
    route_table_name      = var.route_table_name
    nat_gateway_name      = var.nat_gateway_name
    nat_subnets_prefix    = var.nat_subnets_prefix
    
}

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

# output "vpc_name" {
#   value = module.network_test.vpc_name
# }
# variable "vpc_name" {}