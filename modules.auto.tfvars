region         = "ap-south-1"
vpc_name       = "eksclustervpc"
vpc_cidr_block = "192.168.0.0/16"
subnets_name   = ["public-subnet01", "public-subnet02", "private-subnet01", "private-subnet02"]
# Make sure private subnet is "False" and public subnet is "True"
public_subnet_type    = true  #public networking through IGW
private_subnet_type   = false # priavte networking through NAT
cidr_newbits          = 4     # cidr is 16 + 54 => 20 each subnets will have cidr like 10.0.1.0/20
internet_gateway_name = "publicgateway"
#Private rt01 and 02 for private subnets
route_table_name   = ["public-rt01", "private-rt01", "private-rt02"]
nat_gateway_name   = ["sub01-nat", "sub02-nat"]
nat_subnets_prefix = "public"