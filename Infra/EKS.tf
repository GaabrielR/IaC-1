module "eks" {
    source  = "terraform-aws-modules/eks/aws"

    cluster_name = var.ClusterName
    cluster_version = "1.29"
    cluster_endpoint_private_access = true

    vpc_id = module.vpc.vpc_id
    subnet_ids = module.vpc.private_subnets

#   EKS Managed Node Group(s)
    eks_managed_node_groups = {
        Alura = {
            min_size = 1
            max_size = 10
            desired_size = 3
            vpc_security_group_ids = [aws_security_group.SSH_Cluster.id]
            instance_types = ["t2.micro"]
        }
    }
}