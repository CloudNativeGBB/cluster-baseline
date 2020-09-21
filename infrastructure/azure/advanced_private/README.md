# AKS Private Cluster with Advanced Networking

This will provision a "Private" AKS cluster with:
- [Private Cluster](https://docs.microsoft.com/en-us/azure/aks/private-clusters)
- [Outbound Type: UDR](https://docs.microsoft.com/en-us/azure/aks/egress-outboundtype)
- [Restricted Egress Traffic with Azure Firewall and UDRs](https://docs.microsoft.com/en-us/azure/aks/limit-egress-traffic)
- [Private Azure Container Registry via Private Link](https://docs.microsoft.com/en-us/azure/container-registry/container-registry-private-link)


```bash
# From <repo_root>/infrastructure/azure/advanced_private/
# Login to Azure-CLI
# az login

bash provision.sh
```

## Destroy/Cleaning Up

```bash
# From <repo_root>/infrastructure/azure/advanced_private/
# Login to Azure-CLI
# az login

bash destroy.sh
```