terraform {
  required_providers {
    kind = {
      source  = "tehcyx/kind"
      version = "~> 0.6.0"
    }
  }
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