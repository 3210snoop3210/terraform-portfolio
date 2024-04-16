#!/bin/bash

# Get the public IPs of the instances from Terraform Cloud API
WORKSPACE_NAME="aws-dev"
ORG_NAME="margarita30062001"

PUBLIC_IPS=$(curl -s \
  --header "Authorization: Bearer $TOKEN" \
  https://app.terraform.io/api/v2/organizations/$ORG_NAME/workspaces/$WORKSPACE_NAME/outputs \
  | jq -r '.data[] | select(.attributes.name == "public_ips") | .attributes.value[]')

# Get the join token from the Terraform Cloud API
JOIN_TOKEN=$(curl -s \
  --header "Authorization: Bearer $TOKEN" \
  https://app.terraform.io/api/v2/organizations/$ORG_NAME/workspaces/$WORKSPACE_NAME/outputs \
  | jq -r '.data[] | select(.attributes.name == "k3s_token") | .attributes.value')

# Install k3s on the nodes and join them to the master
for ip in $PUBLIC_IPS; do
  ssh -o StrictHostKeyChecking=no ec2-user@${ip} "curl -sfL https://get.k3s.io | K3S_URL=https://${MASTER_IP}:6443 K3S_TOKEN=${JOIN_TOKEN} sh -"
done
