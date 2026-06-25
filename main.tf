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
    helm = {
      source  = "hashicorp/helm"
      version = "~> 2.0"
    }
  }
}

provider "kind" {}

provider "kubernetes" {
  host                   = kind_cluster.learning.endpoint
  client_certificate     = kind_cluster.learning.client_certificate
  client_key             = kind_cluster.learning.client_key
  cluster_ca_certificate = kind_cluster.learning.cluster_ca_certificate
}

provider "helm" {
  kubernetes {
    host                   = kind_cluster.learning.endpoint
    client_certificate     = kind_cluster.learning.client_certificate
    client_key             = kind_cluster.learning.client_key
    cluster_ca_certificate = kind_cluster.learning.cluster_ca_certificate
  }
}
