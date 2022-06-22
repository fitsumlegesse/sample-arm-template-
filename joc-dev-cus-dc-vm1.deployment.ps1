
$subscriptionId = ""
Set-AzContext -Subscriptionid $subscriptionId

$resourceGroupName = ""
$resourceGroupLocation = [string]""

# Create a managment resource group
#Create or check for an existing resource group

$resourceGroup = Get-AzResourceGroup -Name $resourceGroupName -ErrorAction SilentlyContinue
if (!$resourceGroup) {
    Write-Host "Resource group '$resourceGroupName' does not exist.";
    Write-Host "Creating resource group '$resourceGroupName' in location '$resourceGroupLocation'";

    New-AzResourceGroup -Name $resourceGroupName -Location $resourceGroupLocation
    $resourceTags = @{ `
      "Group Name"      = ""; `
      "Budget Code"     = ""; `
      "Project ID"      = ""; `
      "Owner"      = ""; `
      "Deployed By"     = ""; `
      "Internal Owner"  = ""; `
      "Support Contact" = ""; `
      "SL"              = ""; `
      "PL"              = ""; 
}

    # Assign tags to the resource group
    Set-AzResourceGroup -Name $resourceGroupName -Tag $resourceTags
}
else {
    Write-Host "Using existing resource group '$resourceGroupName'";
}

# Start the deployment for a (specify resource type)
Write-Host "Starting deployment for a (specify resource type)";

$templateFilePath = ""
$templateParameterFilePath = ""

$timestamp = ((Get-Date).ToString("MM-dd-yyyy-hh-mm-ss"))
$deploymentName = "" + $timestamp
if (Test-Path $templateParameterFilePath) {
  New-AzResourceGroupDeployment -ResourceGroupName $resourceGroupName -location $resourceGroupLocation -Name $deploymentName -TemplateFile $templateFilePath -TemplateParameterFile $templateParameterFilePath -Mode Incremental -Verbose;
   
}
else {
  New-AzResourceGroupDeployment -ResourceGroupName $resourceGroupName -location $resourceGroupLocation -Name $deploymentName -TemplateFile $templateFilePath  -Mode Incremental -Verbose;
   
}
