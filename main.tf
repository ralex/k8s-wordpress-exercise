terraform {
  required_providers {
    kubernetes = {
      source = "hashicorp/kubernetes"
      version = "2.11.0"
    }
    helm = {
        source = "hashicorp/helm"
        version = "2.7.0"
    }
  }
}

provider "kubernetes" {
  config_path    = "~/.kube/config"
  config_context = "minikube"
}

provider "helm" {
  kubernetes {
    config_path = "~/.kube/config"
  }
}


resource "kubernetes_namespace" "tp" {
  metadata {
    name = "tp"
  }
}

resource "helm_release" "my-wordpress-release" {
  name       = "my-wordpress-release"
  repository = "https://charts.bitnami.com/bitnami"
  chart      = "wordpress"
  version    = "15.2.4"
  namespace  = kubernetes_namespace.tp.id

  values = [
    "${file("values.yaml")}"
  ]

  set {
    name = "replicaCount"
    value = 2
  }
  set {
    name  = "service.type"
    value = "NodePort"
  }
}
