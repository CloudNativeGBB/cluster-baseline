prefix = "cngbb"
suffix = ""
location = "eastus"
network_plugin = "azure"
network_policy = "calico"
load_balancer_sku = "Standard"
service_cidr = "192.168.0.0/24"
dns_service_ip = "192.168.0.10"
docker_bridge_cidr = "172.17.0.1/24"

default_nodepool = {
	name = "default"
	vm_size = "standard_d4s_v3"
	os_disk_size_gb = 30
	os_disk_type = "Ephemeral"
	max_pods = 30
	node_count = 2
	enable_auto_scaling = {
		enabled = true
		min_count = 1
		max_count = 5
	}
}

nodepools = {
	nodepool1 = {
		np_sku_size = "standard_f16s_v2"
		mode = "User"
		os_disk_type = "Ephemeral" 
		os_disk_size_gb = 256
		node_count = 2
		enable_auto_scaling = {
			enabled = true
			min_count = 1
			max_count = 5
		}
	},
	nodepool2 = {
		np_sku_size = "standard_f8s_v2"
		mode = "User"
		os_disk_type = "Ephemeral" 
		os_disk_size_gb = 128
		node_count = 1
		enable_auto_scaling = {
			enabled = true
			min_count = 1
			max_count = 5
		}
	},
	nodepool3 = {
		np_sku_size = "standard_d4s_v3"
		mode = "User"
		os_disk_type = "Ephemeral" 
		os_disk_size_gb = 30
		node_count = 1
		enable_auto_scaling = {
			enabled = true
			min_count = 1
			max_count = 5
		}
	}
}