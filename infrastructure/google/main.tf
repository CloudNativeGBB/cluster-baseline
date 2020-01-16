module "gke" {
  source                     = "terraform-google-modules/kubernetes-engine/google"
  version                    = "6.2.0"
  project_id                 = local.project_id
  name                       = local.name
  region                     = local.region
  network                    = local.network 
  subnetwork                 = local.subnetwork
  ip_range_pods              = local.ip_range_pods
  ip_range_services          = local.ip_range_services
  http_load_balancing        = false
  horizontal_pod_autoscaling = true
  network_policy             = true

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