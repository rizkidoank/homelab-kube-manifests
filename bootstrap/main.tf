terraform {

  backend "gcs" {
    bucket = "tfstate-016c1997c5b3085f"
    prefix = "homelab/k8s/bootstrap"
  }

  required_providers {
    helm = {
      source  = "hashicorp/helm"
      version = "2.15.0"
    }

    kubernetes = {
      source  = "hashicorp/kubernetes"
      version = "2.32.0"
    }
  }
}

provider "helm" {
  kubernetes {
    config_path = "~/.kube/config"
  }
}

provider "kubernetes" {
  config_path = "~/.kube/config"
}

resource "kubernetes_namespace" "infrastructure" {
  metadata {
    name = "infrastructure"
  }
}

resource "helm_release" "argocd" {
  depends_on = [ helm_release.tigera_operator ]
  name       = "argocd"
  chart      = "argo-cd"
  repository = "https://argoproj.github.io/argo-helm"
  version    = "7.6.0"
  namespace  = kubernetes_namespace.infrastructure.metadata[0].name

  values = ["${file("values.yaml")}"]
}

resource "helm_release" "tigera_operator" {
  name       = "tigera-operator"
  chart      = "tigera-operator"
  repository = "https://docs.projectcalico.org/charts/"
  version    = "3.28.2"
  namespace  = kubernetes_namespace.infrastructure.metadata[0].name
}
