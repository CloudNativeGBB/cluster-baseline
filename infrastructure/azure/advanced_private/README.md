# AKS Private Cluster with Advanced Networking

This will provision an AKS cluster with:
- [Private Cluster](https://docs.microsoft.com/en-us/azure/aks/private-clusters)
- [Outbound Type: UDR](https://docs.microsoft.com/en-us/azure/aks/egress-outboundtype)
- [Restricted Egress Traffic with Azure Firewall](https://docs.microsoft.com/en-us/azure/aks/limit-egress-traffic)


```bash
terraform init networking
terraform plan -out networking/tfplan
terraform apply networking/tfplan -auto-approve

terraform init aks/
terraform plan -out aks/tfplan
terraform apply aks/tfplan -auto-approve
```