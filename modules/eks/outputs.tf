output "endpoint" {
  value = aws_eks_cluster.cluster.endpoint
}
output "kubeconfig_ca" {
  value = base64decode(aws_eks_cluster.cluster.certificate_authority.0.data)
}

