resource "google_container_cluster" "primary" {
  name     = local.cluster_name
  location = local.location

  # We can't create a cluster with no node pool defined, but we want to only use
  # separately managed node pools. So we create the smallest possible default
  # node pool and immediately delete it.
  remove_default_node_pool = true
  initial_node_count       = 1
}

resource "google_container_node_pool" "node_pool_1" {
  name       = "my-node-pool"
  location   = local.location
  cluster    = google_container_cluster.primary.name
  node_count = local.node_count

  node_config {

    machine_type = local.machine_type

    oauth_scopes = [
      "https://www.googleapis.com/auth/logging.write",
      "https://www.googleapis.com/auth/monitoring",
    ]
  }
}