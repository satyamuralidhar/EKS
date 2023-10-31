region         = "ap-south-1"
vpc_name       = "eksclustervpc"
vpc_cidr_block = "192.168.0.0/16"
subnets_name   = ["public-subnet01", "public-subnet02", "private-subnet01", "private-subnet02"]
# Make sure private subnet is "False" and public subnet is "True"
public_subnet_type    = true  #public networking through IGW
private_subnet_type   = false # priavte networking through NAT
cidr_newbits          = 4     # cidr is 16 + 4 => 20 each subnets will have cidr like 10.0.1.0/20
internet_gateway_name = "publicgateway"
#Private rt01 and 02 for private subnets
route_table_name   = ["public-rt01", "private-rt01", "private-rt02"]
nat_gateway_name   = ["sub01-nat", "sub02-nat"]
nat_subnets_prefix = "public"


#Kubernetes
eks_cluster_name            = "myeks"
eks_node_group_name         = ["eksclusternodegrp01", "eksclusternodegrp02"]
eks_cluster_iam_role_name   = "eksclusterrole"
eks_nodegroup_iam_role_name = "eksnodegrouprole"



eks_cluster_policy_arns = {
  AmazonEKSClusterPolicy             = "arn:aws:iam::aws:policy/AmazonEKSClusterPolicy"
  AmazonEKSVPCResourceController     = "arn:aws:iam::aws:policy/AmazonEKSVPCResourceController"
  AmazonEC2ContainerRegistryReadOnly = "arn:aws:iam::aws:policy/AmazonEC2ContainerRegistryReadOnly"
}

eks_nodegroup_policy_arns = {
  AmazonEKSWorkerNodePolicy          = "arn:aws:iam::aws:policy/AmazonEKSWorkerNodePolicy"
  AmazonEKS_CNI_Policy               = "arn:aws:iam::aws:policy/AmazonEKS_CNI_Policy"
  AmazonEC2ContainerRegistryReadOnly = "arn:aws:iam::aws:policy/AmazonEC2ContainerRegistryReadOnly"

}

eks_scaling_config = {
  "scaling01" = {
    desired_size = 2
    max_size     = 3
    min_size     = 2
  }
}

eks_instance_types = ["t3.medium"]
eks_ami_type       = "AL2_x86_64"
eks_disk_size      = 20
#eks_capacity_type  = "ON_DEMAND"