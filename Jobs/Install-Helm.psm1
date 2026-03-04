function Install-Helm
{
    $appName = "Helm.Helm"
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
    $helmCommand = Get-Command helm.exe -ErrorAction SilentlyContinue
    if ($null -eq $helmCommand) {
        Write-Warning "HELM_HOME ayarlanamadi. helm.exe bulunamadi."
        return
    }

    $destinationRoot = Split-Path -Path $helmCommand.Source -Parent
    [Environment]::SetEnvironmentVariable("HELM_HOME", $destinationRoot, "Machine")

    $machinePathItems = @(([Environment]::GetEnvironmentVariable("Path", "Machine") -split ';') | Where-Object { $_ -ne "" })
    if ($machinePathItems -contains "%HELM_HOME%") {
        Write-Host "🐨 HELM_HOME ayarli tesekkurler"
    }
    else {
        Write-Host "👽 HELM_HOME ayarlaniyor"
        $oldPath = [Environment]::GetEnvironmentVariable("Path", "Machine") + ";%HELM_HOME%"
        [Environment]::SetEnvironmentVariable("Path", $oldPath, "Machine")
    }
}

Export-ModuleMember -Function Install-Helm
