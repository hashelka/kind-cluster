terraform {
  required_providers {
    kind = {
      source  = "tehcyx/kind"
      version = "~> 0.6.0"
    }
    kubernetes = {
      source  = "hashicorp/kubernetes"
      version = "~> 2.0"
    }
  }
}

provider "kubernetes" {
  host                   = kind_cluster.learning.endpoint
  client_certificate     = kind_cluster.learning.client_certificate
  client_key             = kind_cluster.learning.client_key
  cluster_ca_certificate = kind_cluster.learning.cluster_ca_certificate
}

provider "kind" {}

resource "kind_cluster" "learning" {
  name            = var.cluster_name
  wait_for_ready  = true

  kind_config {
    kind        = "Cluster"
    api_version = "kind.x-k8s.io/v1alpha4"

    node {
      role = "control-plane"
    }

    node {
      role = "worker"
      labels = {
        "node-tier" = "app"
      }
    }

    node {
      role = "worker"
      labels = {
        "app" = "argocd"
      }
    }
  }
}