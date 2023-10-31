variables {
    vpc_name       = "eksclustervpc"
    vpc_cidr_block = "192.168.0.0/16"
    subnets_name   = ["public-subnet01", "public-subnet02", "private-subnet01", "private-subnet02"]
    public_subnet_type    = true 
    private_subnet_type   = false 
    cidr_newbits          = 4 
    internet_gateway_name = "publicgateway"
    route_table_name   = ["public-rt01", "private-rt01", "private-rt02"]
    nat_gateway_name   = ["sub01-nat", "sub02-nat"]
    nat_subnets_prefix = "public"
}

 run "network_expected_failures" {
     command = plan
     module {
         source = "./tests/setup/"
     }
     variables {
         vpc_name       = "eksclustervpc001"
         vpc_cidr_block = "192.168.0.0/20"
         subnets_name   = ["public-subnet001", "public-subnet002", "private-subnet001", "private-subnet002"]
         public_subnet_type    = false
         private_subnet_type   = true 
         cidr_newbits          = 3
         internet_gateway_name = "publicgateway01"
         route_table_name   = ["public-rt001", "private-rt001", "private-rt002"]
         nat_gateway_name   = ["sub01-natt", "sub02-natt"]
         nat_subnets_prefix = "publics"
     }
     expect_failures = [
         var.vpc_name,
         var.vpc_cidr_block,
         var.subnets_name,
         var.public_subnet_type,
         var.private_subnet_type,
         var.cidr_newbits,
         var.internet_gateway_name,
         var.route_table_name,
         var.nat_gateway_name,
         var.nat_subnets_prefix
     ]
 }

run "network_unit_testing" {
    command = plan
    module {
        source = "./tests/setup"
    }
    
    variables {
        vpc_name       = var.vpc_name
        vpc_cidr_block = var.vpc_cidr_block
        subnets_name   = var.subnets_name
        public_subnet_type    = var.public_subnet_type
        private_subnet_type   = var.private_subnet_type
        cidr_newbits          = var.cidr_newbits
        internet_gateway_name = var.internet_gateway_name
        route_table_name   = var.route_table_name
        nat_gateway_name   = var.nat_gateway_name
        nat_subnets_prefix = var.nat_subnets_prefix
    }

    assert {
        condition = module.Network.vpc_name == var.vpc_name
        error_message = "invalid vpc name"
    }

    assert {
        condition = module.Network.vpc_cidr_block == var.vpc_cidr_block
        error_message = "invalid vpc cidr range"
    }

    
    assert {
        condition = module.Network.subnets_name == var.subnets_name && length(var.subnets_name) >= 4
        error_message = "invalid subnet names"
    }

    assert {
        condition = module.Network.public_subnet_type == var.public_subnet_type
        error_message = "subnet type must be true"
    }
    assert {
        condition = module.Network.private_subnet_type == var.private_subnet_type
        error_message = "subnet type must be false"
    }
    assert {
        condition = module.Network.cidr_newbits  == var.cidr_newbits 
        error_message = "cidr netbits values has been 4"
    }
    assert {
        condition = module.Network.internet_gateway_name  == var.internet_gateway_name
        error_message = "Enter proper internet gateway name"
    }
    assert {
        condition = module.Network.route_table_name  == var.route_table_name && length(var.route_table_name) >=3
        error_message =  "Enter proper route table name"
    }
    assert {
        condition = module.Network.nat_gateway_name == var.nat_gateway_name && length(var.nat_gateway_name) >=2 
        error_message =  "Enter proper nat gateway names"
    }
    assert {
        condition = module.Network.nat_subnets_prefix   == var.nat_subnets_prefix 
        error_message = "Enter proper subnet prefix"
    }

}
