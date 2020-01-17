resource "google_compute_network" "azure-arc-demo" {
  name = local.network_name
}

resource "google_compute_subnetwork" "azure-arc-demo" {
    name = local.cluster_subnetwork_name
    region = local.region
    network = google_compute_network.azure-arc-demo.name
    ip_cidr_range = local.cluster_subnetwork_cidr

    secondary_ip_range = [
        {
            range_name = local.services_range_name
            ip_cidr_range = local.services_range_cidr
        },
        {
            range_name = local.pod_range_name
            ip_cidr_range = local.pod_range_cidr
        }
    ]
}