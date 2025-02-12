function Build-Plugin {
    Write-Host "Building declarative agent"
    Push-Location "../"

    # If node_modules folder is not present then install the dependencies
    if(!(Test-Path "node_modules"))
    {
        Write-Host "Install module dependencies."
        npm install
    }

    # Compile the Agent Description
    Write-Host "Compile the Agent Description."
    tsp compile .

    # Use kiota to produce all of the plugin manifests
    $Env:KIOTA_CONFIG_PREVIEW = "true"
    $KiotaDirNotExists = !(Test-Path ".kiota")
    # TODO: Replace this first time step with the emitter for workspace.json
    if($KiotaDirNotExists) # Create a Kiota workspace
    {
        # TODO: Fix single plugin generation because no namespace is generated and file reference in declarativeAgent.json will be wrong
        # for now, special case $PluginName when file is named openapi.json
        Get-ChildItem -Path ".generated/openapi" -Filter "openapi*.json" | ForEach-Object {
            if ($_.Name -eq "openapi.json") {
                $json = Get-Content -Path ".generated/declarativeAgent.json" | ConvertFrom-Json
                $GeneratedName = $json.actions[0].file
                $PluginName = $GeneratedName.Split('-')[0]
            } else {
                $FileName = $_.BaseName.Split('.')
                $PluginName = $FileName[$FileName.Length - 1]
            }

            Write-Host "Calling Kiota for the first time. Adding plugin $PluginName."
            kiota plugin add -d $_.FullName --plugin-name $PluginName --output .generated/plugins/$PluginName --type apiplugin
        }
    }

    Write-Host "Calling Kiota to refresh artifacts for all plugins described in workspace file."
    kiota plugin generate --refresh

    # Move the generated manifests and matching OpenAPI files to the appPackage folder
    Copy-Item -Path ".generated/plugins/*/*" -Destination "appPackage" -Force -ErrorAction SilentlyContinue
    Copy-Item -Path ".generated/declarativeAgent.json" -Destination "appPackage" -Force
    Pop-Location
}