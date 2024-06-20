resource "kubernetes_deployment" "Django-API" {
    metadata {
      name = "django-api"
      labels = {
        nome = "django"
      }
    }

    spec {
        replicas = 3

        selector {
          match_labels = {
            nome = "django"
          }
        }

        template {
          metadata {
            labels = {
              nome = "django"
            }
          }
          
          spec {
            container {
              image = "975050151604.dkr.ecr.us-west-2.amazonaws.com/producao:v1"
              name = "Django-Producao"

              resources {
                limits = {
                  cpu = "0.5"
                  memory = "512Mi"
                }
                requests = {
                  cpu = "250m"
                  memory = "50Mi"
                }
              }

              liveness_probe {
                http_get {
                  path = "/clientes/"
                  port = 8000
                }

                initial_delay_seconds = 3
                period_seconds = 3
              }
            }
          }
        }
    }
}

resource "kubernetes_service" "KubeLoadBalancer" {
    metadata {
      name = "loadbalancer-django-api"
    }
    spec {
        selector = {
            nome = "django"
        }
        port {
          port = 8000
          target_port = 8000
        }
        type = "LoadBalancer"
    }
}

data "kubernetes_service" "NomeDNS" {
    metadata {
      name = "loadbalancer-django-api"
    }
}

output "URL-LoadBalancer-Kubernetes" {
    value = data.kubernetes_service.NomeDNS.status
}