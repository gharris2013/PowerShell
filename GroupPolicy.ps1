# Import the GroupPolicy module
Import-Module GroupPolicy

# Define the Group Policy name and scope
$policyName = "Block USB Storage"
$policyScope = "User"

# Create a new Group Policy object
$policy = New-GPO -Name $policyName

# Get the Group Policy container
$gpoContainer = Get-GPOContainer -Target $policyScope

# Link the Group Policy to the container
Link-GPO -Name $policyName -Container $gpoContainer

# Open the Group Policy for editing
$policyPath = Join-Path -Path $gpoContainer -ChildPath $policy.Id
$gpedit = Open-GPOEditor -Path $policyPath

# Create a new Administrative Template Policy
$adminTemplate = New-AdminTemplate -Path "C:\Templates\usbstorage.admx"

# Add the Administrative Template to the Group Policy
Add-AdminTemplate -GPO $gpedit -AdminTemplate $adminTemplate

# Set the configuration of the Administrative Template
Set-AdminTemplateProperty -GPO $gpedit -AdminTemplate $adminTemplate -Property "USB Storage" -Value "Disabled"

# Save and close the Group Policy Editor
Close-GPOEditor -Path $policyPath
