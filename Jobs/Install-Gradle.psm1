function Install-Gradle
{
    $gradleVersion = "9.1.0"
    $destinationRoot = "C:\gradle"
    $archiveName = "gradle-$gradleVersion-bin.zip"
    $downloadUrl = "https://services.gradle.org/distributions/$archiveName"
    $tempZip = Join-Path $env:TEMP $archiveName
    $tempExtractRoot = Join-Path $env:TEMP "gradle-$gradleVersion"

    Edit-Paths -FolderToCreate $destinationRoot
    New-Item -Path $destinationRoot -ItemType Directory -Force | Out-Null

    Write-Host "🧑‍🏭 Gradle $gradleVersion indiriliyor"
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

    [Environment]::SetEnvironmentVariable("GRADLE_HOME", $destinationRoot, "Machine")

    $machinePathItems = @(([Environment]::GetEnvironmentVariable("Path", "Machine") -split ';') | Where-Object { $_ -ne "" })
    if ($machinePathItems -contains "%GRADLE_HOME%\bin") {
        Write-Host "🐨 GRADLE_HOME ayarli tesekkurler"
    }
    else {
        Write-Host "👽 GRADLE_HOME ayarlaniyor"
        $oldPath = [Environment]::GetEnvironmentVariable("Path", "Machine") + ";%GRADLE_HOME%\bin"
        [Environment]::SetEnvironmentVariable("Path", $oldPath, "Machine")
    }
}

Export-ModuleMember -Function Install-Gradle
