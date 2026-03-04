function Install-NuGet-CLI {
    Write-Host "🧑‍🏭 NuGet-CLI kuruluyor..."

    $appName = "Microsoft.NuGet"
    $listApp = (winget list --id $appName)[-1]

    if (![String]::Join("", $listApp).Contains($appName)) {
        Write-Host "🧑‍🏭 $appName kuruluyor"
        winget install -e -h --scope machine --accept-source-agreements --accept-package-agreements --id $appName
    }
    else {
        Write-Host "♻️ $appName kurulu guncelleniyor.."
        winget upgrade -e -h --scope machine --accept-source-agreements --accept-package-agreements --id $appName
    }

    $Env:Path = [System.Environment]::GetEnvironmentVariable("Path","Machine") + ";" + [System.Environment]::GetEnvironmentVariable("Path","User")
    $nugetCommand = Get-Command nuget.exe -ErrorAction SilentlyContinue
    if ($null -eq $nugetCommand) {
        Write-Warning "NUGET_CLI_HOME ayarlanamadi. nuget.exe bulunamadi."
        return
    }

    $dest = Split-Path -Path $nugetCommand.Source -Parent
    [Environment]::SetEnvironmentVariable("NUGET_CLI_HOME", $dest, "Machine")

    $machinePathItems = @(([Environment]::GetEnvironmentVariable("Path", "Machine") -split ';') | Where-Object { $_ -ne "" })
    if ($machinePathItems -contains "%NUGET_CLI_HOME%") {
        Write-Host "🐨 NUGET_CLI_HOME ayarli tesekkurler"
    }
    else {
        Write-Host "👽 NUGET_CLI_HOME ayarlaniyor"
        $oldPath = [Environment]::GetEnvironmentVariable("Path", "Machine") + ";%NUGET_CLI_HOME%"
        [Environment]::SetEnvironmentVariable("Path", $oldPath, "Machine")
    }
}

Export-ModuleMember -Function Install-NuGet-CLI
