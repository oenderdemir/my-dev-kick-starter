function Install-Maven
{
    $mavenVersion = "3.9.12"
    $destinationRoot = "C:\maven"
    $archiveName = "apache-maven-$mavenVersion-bin.zip"
    $downloadUrl = "https://dlcdn.apache.org/maven/maven-3/$mavenVersion/binaries/$archiveName"
    $tempZip = Join-Path $env:TEMP $archiveName
    $tempExtractRoot = Join-Path $env:TEMP "apache-maven-$mavenVersion"

    Edit-Paths -FolderToCreate $destinationRoot
    New-Item -Path $destinationRoot -ItemType Directory -Force | Out-Null

    Write-Host "🧑‍🏭 Maven $mavenVersion indiriliyor"
    Invoke-WebRequest -Uri $downloadUrl -OutFile $tempZip

    if (Test-Path $tempExtractRoot) {
        Remove-Item -Path $tempExtractRoot -Recurse -Force
    }

    Expand-Archive -Path $tempZip -DestinationPath $env:TEMP -Force
    Copy-Item -Path (Join-Path $tempExtractRoot "*") -Destination $destinationRoot -Recurse -Force

    Remove-Item -Path $tempZip -Force -ErrorAction SilentlyContinue
    if (Test-Path $tempExtractRoot) {
        Remove-Item -Path $tempExtractRoot -Recurse -Force
    }

    [Environment]::SetEnvironmentVariable("M2_HOME", $destinationRoot, "Machine")

    $machinePathItems = @(([Environment]::GetEnvironmentVariable("Path", "Machine") -split ';') | Where-Object { $_ -ne "" })
    if ($machinePathItems -contains "%M2_HOME%\bin") {
        Write-Host "🐨 M2_HOME ayarli tesekkurler"
    }
    else {
        Write-Host "👽 M2_HOME ayarlaniyor"
        $oldPath = [Environment]::GetEnvironmentVariable("Path", "Machine") + ";%M2_HOME%\bin"
        [Environment]::SetEnvironmentVariable("Path", $oldPath, "Machine")
    }
}

Export-ModuleMember -Function Install-Maven
