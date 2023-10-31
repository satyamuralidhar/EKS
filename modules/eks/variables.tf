variable "eks_cluster_name" {}
variable "eks_cluster_iam_role_name" {}
variable "eks_node_group_name" {}
variable "eks_cluster_subnet_ids" {}
variable "eks_nodegroup_subnet_ids" {}
variable "eks_cluster_policy_arns" {}
variable "eks_nodegroup_policy_arns" {}
variable "eks_nodegroup_iam_role_name" {}
variable "eks_instance_types" {}
variable "eks_ami_type" {}
variable "eks_disk_size" {}
#variable "eks_capacity_type" {}
variable "eks_scaling_config" {
    type = map(object({
      desired_size = number
      max_size = number
      min_size = number
    }))
}

