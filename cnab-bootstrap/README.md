porter credentials generate azure --tag stevegriffith/arc-bootstrap:v0.1.0

porter install --cred ~/.porter/credentials/azure.json \
  --tag stevegriffith/arc-bootstrap:v0.1.0 \
  --param arc_resource_group=EphPorterDemo \
  --param arc_cluster_name=porterarc \
  --param la_workspace_rg=EphPorterDemo \
  --param la_workspace_name=porterdemo-la 