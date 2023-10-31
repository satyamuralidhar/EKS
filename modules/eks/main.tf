data "aws_iam_policy_document" "assume_role" {
  statement {
    effect = "Allow"

    principals {
      type        = "Service"
      identifiers = ["eks.amazonaws.com"]
    }

    actions = ["sts:AssumeRole"]
  }
}

resource "aws_iam_role" "eksrole" {
  name               = var.eks_cluster_iam_role_name
  assume_role_policy = data.aws_iam_policy_document.assume_role.json
}

resource "aws_iam_role_policy_attachment" "cluster_arns" {
  for_each = var.eks_cluster_policy_arns
  policy_arn = each.value
  role       = aws_iam_role.eksrole.name
}

resource "aws_eks_cluster" "cluster" {
  name     = var.eks_cluster_name
  role_arn = aws_iam_role.eksrole.arn

  vpc_config {
    subnet_ids = [var.eks_cluster_subnet_ids]
  }

  depends_on = [
    aws_iam_role_policy_attachment.cluster_arns
  ]
}


resource "aws_iam_role" "nodegrouprole" {
  name = var.eks_nodegroup_iam_role_name

  assume_role_policy = jsonencode({
    Statement = [{
      Action = "sts:AssumeRole"
      Effect = "Allow"
      Principal = {
        Service = "ec2.amazonaws.com"
      }
    }]
    Version = "2012-10-17"
  })
}

resource "aws_iam_role_policy_attachment" "node_group_arns" {
  for_each = var.eks_nodegroup_policy_arns
  policy_arn = each.value
  role       = aws_iam_role.nodegrouprole.name
}


resource "aws_eks_node_group" "node_group" {
  for_each = toset(var.eks_node_group_name)
  cluster_name    = aws_eks_cluster.cluster.name
  node_group_name = each.value
  node_role_arn   = aws_iam_role.eksrole.arn
  subnet_ids      = [index(var.eks_nodegroup_subnet_ids,each.value)]
  instance_types = var.eks_instance_types
  disk_size = var.eks_disk_size
  #capacity_type = var.eks_capacity_type
  ami_type = var.eks_ami_type

  
  dynamic "scaling_config" {
    for_each = var.eks_scaling_config
    iterator = scale
    content {
      desired_size = scale.value.desired_size
      max_size = scale.value.max_size
      min_size = scale.value.min_size
      
    }
  }
  depends_on = [
    aws_iam_role_policy_attachment.node_group_arns
  ]
}


