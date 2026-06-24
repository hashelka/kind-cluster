output "cluster_name" {
  value = kind_cluster.learning.name
}

output "kubeconfig" {
  value     = kind_cluster.learning.kubeconfig
  sensitive = true
}