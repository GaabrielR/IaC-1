terraform {
  required_providers {
    aws = {
        source = "hashicorp/aws"
        version = "~> 5.40.0"
    }
  }

  required_version = ">= 1.2.0"
}

provider "aws" {
  profile = "default"
  region = "us-west-2"
}

# provider "kubernetes" {
#   host = module.eks.cluster_endpoint
#   cluster_ca_certificate = base64decode(module.eks.cluster_certificate_authority_data)

#   exec {
#     api_version = "client.authentication.k8s.io/v1beta1"
#     command = "aws"
#     args = ["eks", "get-token", "--cluster-name", module.eks.cluster_name]
#   }  
# }

data "aws_eks_cluster" "ClusterDefault" {
  name = var.ClusterName
  depends_on = [ module.eks.eks_managed_node_groups ]
}

data "aws_eks_cluster_auth" "ClusterAuthDefault" {
  name = var.ClusterName
}

provider "kubernetes" {
  host = data.aws_eks_cluster.ClusterDefault.endpoint
  cluster_ca_certificate = base64decode(data.aws_eks_cluster.ClusterDefault.certificate_authority[0].data)
  token = data.aws_eks_cluster_auth.ClusterAuthDefault.token
}