module "Prod" {
  source = "../../Infra"

  Nome_Repositório = "RepositorioProducao"
  ClusterName = "ClusterProducao"
}

output "Endereco-LoadBalancer-Kubernetes" {
  value = module.Prod.URL-LoadBalancer-Kubernetes
}