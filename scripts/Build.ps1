# This scripts builds the project

$CurrentLocation = Get-Location
# Set the working directory to the project root
Push-Location -Path $PSScriptRoot

##-------------------------------------------
## Load Script Libraries
##-------------------------------------------
Get-ChildItem "./Functions/*.ps1" | ForEach-Object {. (Join-Path "Functions" $_.Name)} | Out-Null

try
{
    Set-AppVersion

    # Builds the Plugin
    Build-Plugin
    
    # Pops the initial directory from the stack
    Pop-Location
}
catch 
{
    Write-Host "Error: $_"
}
finally 
{
    Set-Location $CurrentLocation
}