$SubscriptionId = '<AZURE SUBSCRIPTION ID>'
$yourUniqueIdentifier = "<YOUR_UNIQUE_IDENTIFIER>"  # e.g. "johnsmith"
$randomstring = (-join ( (97..122) | Get-Random -Count 6 | % {[char]$_}))
$resourceGroupName = "rg-openai-workshop-"+ $yourUniqueIdentifier + "-" + $randomstring;
$location = "<AZURE_REGION>"


# Set subscription 
Set-AzContext -SubscriptionId $subscriptionId 
# Create a resource group
New-AzResourceGroup -Name $resourceGroupName -Location $location

New-AzResourceGroupDeployment -ResourceGroupName $resourceGroupName -TemplateFile deployAll.bicep -WarningAction:SilentlyContinue



