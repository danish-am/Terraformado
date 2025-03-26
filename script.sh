#!/bin/bash

set -e

# Variables
RESOURCE_GROUP_NAME=terraform-state-rg
TEST_SA_ACCOUNT=tftestbackend
DEV_SA_ACCOUNT=tfdevbackend
CONTAINER_NAME=tfstate
LOCATION=canadacentral

# These should be set securely in Azure DevOps pipeline variables
SP_APP_ID=$ARM_CLIENT_ID
SP_SECRET=$ARM_CLIENT_SECRET
SP_TENANT_ID=$ARM_TENANT_ID
SUBSCRIPTION_ID=$ARM_SUBSCRIPTION_ID

# Install Azure CLI if not present
if ! command -v az &> /dev/null; then
    echo "Azure CLI not found. Installing..."
    curl -sL https://aka.ms/InstallAzureCLIDeb | sudo bash
else
    echo "✅ Azure CLI already installed"
fi

# Authenticate to Azure using Service Principal
echo "🔐 Logging into Azure..."
az login --service-principal -u "$SP_APP_ID" -p "$SP_SECRET" --tenant "$SP_TENANT_ID" > /dev/null

# Set subscription
az account set --subscription "$SUBSCRIPTION_ID"

# Create resource group
echo "📦 Creating resource group..."
az group create --name $RESOURCE_GROUP_NAME --location $LOCATION

# Create storage accounts
echo "📦 Creating storage accounts..."
az storage account create --resource-group $RESOURCE_GROUP_NAME --name $TEST_SA_ACCOUNT --sku Standard_LRS --encryption-services blob --location $LOCATION
az storage account create --resource-group $RESOURCE_GROUP_NAME --name $DEV_SA_ACCOUNT --sku Standard_LRS --encryption-services blob --location $LOCATION

# Get access keys
TEST_KEY=$(az storage account keys list --resource-group $RESOURCE_GROUP_NAME --account-name $TEST_SA_ACCOUNT --query "[0].value" -o tsv)
DEV_KEY=$(az storage account keys list --resource-group $RESOURCE_GROUP_NAME --account-name $DEV_SA_ACCOUNT --query "[0].value" -o tsv)

# Create blob containers
echo "📦 Creating blob containers..."
az storage container create --name $CONTAINER_NAME --account-name $TEST_SA_ACCOUNT --account-key $TEST_KEY
az storage container create --name $CONTAINER_NAME --account-name $DEV_SA_ACCOUNT --account-key $DEV_KEY

echo "✅ Backend resources created successfully."
