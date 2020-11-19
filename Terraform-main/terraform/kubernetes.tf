terraform {
  required_providers {
    kubernetes = {
      source = "hashicorp/kubernetes"
    }
  }
}

provider "kubernetes" {}

resource "kubernetes_deployment" "python" {
  metadata {
    name = "python"
    labels = {
      App = "python"
    }
  }

  spec {
    replicas = 2
    selector {
      match_labels = {
        App = "python"
      }
    }
    template {
      metadata {
        labels = {
          App = "python"
        }
      }
      spec {
        container {
          image = "mmmahon64/python:0.0.3.RELEASE"
          name  = "python"

          port {
            container_port = 80
          }

          resources {
            limits {
              cpu    = "0.5"
              memory = "512Mi"
            }
            requests {
              cpu    = "250m"
              memory = "50Mi"
            }
          }
        }
      }
    }
  }
}

resource "kubernetes_service" "python" {
  metadata {
    name = "python"
  }
  spec {
    selector = {
      App = kubernetes_deployment.python.spec.0.template.0.metadata[0].labels.App
    }
    port {
      port        = 80
      target_port = 80
    }

    type = "LoadBalancer"
  }
}