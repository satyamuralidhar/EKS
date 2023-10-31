provider "aws" {
  region = var.region
}

provider "kubernetes" {
  host                   = module.Kubernetes.endpoint
  cluster_ca_certificate = base64decode(module.Kubernetes.kubeconfig_ca)
}


