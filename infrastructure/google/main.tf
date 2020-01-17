module "gke" {
  source                     = "terraform-google-modules/kubernetes-engine/google"
  version                    = "6.2.0"
  project_id                 = google_project.azure-arc-demo.name
  name                       = local.cluster_name
  region                     = local.region
  network                    = google_network.azure-arc-demo.name
  subnetwork                 = google_subnetwork.azure-arc-demo.name
  ip_range_pods              = google_subnetwork.azure-arc-demo.secondary_ip_range[0].range_name
  ip_range_services          = google_subnetwork.azure-arc-demo.secondary_ip_range[1].range_name
  http_load_balancing        = false
  horizontal_pod_autoscaling = true
  network_policy             = true

  kubernetes_version         = local.kubernetes_version

  node_pools = [
    {
      name               = "default-node-pool"
      machine_type       = "n1-standard-2"
      min_count          = 1
      max_count          = 4
      auto_upgrade       = false
      initial_node_count = 1
    },
  ]

  node_pools_oauth_scopes = {
    all = []

    default-node-pool = [
      "https://www.googleapis.com/auth/cloud-platform",
    ]
  }

  node_pools_labels = {
    all = {}

    default-node-pool = {
      default-node-pool = true
    }
  }

  node_pools_metadata = {
    all = {}

    default-node-pool = {
      node-pool-metadata-custom-value = "my-node-pool"
    }
  }

}