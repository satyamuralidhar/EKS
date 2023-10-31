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

#kubernetes
variable "eks_cluster_name" {}
variable "eks_node_group_name" {}
variable "eks_cluster_subnet_ids" {}
variable "eks_nodegroup_subnet_ids" {}
#variable "eks_capacity_type" {}

#IAM
variable "eks_nodegroup_iam_role_name" {}
variable "eks_cluster_iam_role_name" {}
variable "eks_cluster_policy_arns" {}
variable "eks_nodegroup_policy_arns" {}
variable "eks_instance_types" {}
variable "eks_ami_type" {}
variable "eks_disk_size" {}


variable "eks_scaling_config" {
  type = map(object({
    desired_size = number
    max_size     = number
    min_size     = number
  }))
}

