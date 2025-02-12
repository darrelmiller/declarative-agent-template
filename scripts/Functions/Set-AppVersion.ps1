function Set-AppVersion {
     Write-Host "Incrementing app point version"
    # increment version in .env.dev file

    # Define the file path
    $filePath = "../env/.env.dev"

    # Read the file content
    $content = Get-Content -Path $filePath

    # Define the parameter name
    $paramName = "TEAMS_APP_VERSION"

    # Iterate through each line to find and update the parameter
    for ($i = 0; $i -lt $content.Length; $i++) {
        if ($content[$i] -match "^$paramName=(.*)$") {
            $version = $matches
            # Value is in match object group match part. Split the version by dots and update the right-most value
            $versionParts = $version[1] -split "\."
            $versionParts[-1] = [int]$versionParts[-1] + 1
            $newVersion = $versionParts -join "."
            # Update the line with the new version
            $content[$i] = "$paramName=$newVersion"
            break; # assume only 1 version value to update
        }
    }

    # Write the updated content back to the file
    Set-Content -Path $filePath -Value $content

    Write-Output "Updated $paramName to $newVersion in $filePath"
}
