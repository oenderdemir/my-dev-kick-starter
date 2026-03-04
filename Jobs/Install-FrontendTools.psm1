function Install-FrontendTools
{
    $nodeAppName = "OpenJS.NodeJS.LTS"
    $nodeList = (winget list --id $nodeAppName)[-1]
    if (![String]::Join("", $nodeList).Contains($nodeAppName)) {
        Write-Host "🧑‍🏭 $nodeAppName kuruluyor"
        winget install -e -h --scope machine --accept-source-agreements --accept-package-agreements --id $nodeAppName
    }
    else {
        Write-Host "♻️ $nodeAppName kurulu guncelleniyor.."
        winget upgrade -e -h --scope machine --accept-source-agreements --accept-package-agreements --id $nodeAppName
    }

    $yarnAppName = "Yarn.Yarn"
    $yarnList = (winget list --id $yarnAppName)[-1]
    if (![String]::Join("", $yarnList).Contains($yarnAppName)) {
        Write-Host "🧑‍🏭 $yarnAppName kuruluyor"
        winget install -e -h --scope machine --accept-source-agreements --accept-package-agreements --id $yarnAppName
    }
    else {
        Write-Host "♻️ $yarnAppName kurulu guncelleniyor.."
        winget upgrade -e -h --scope machine --accept-source-agreements --accept-package-agreements --id $yarnAppName
    }

    $Env:Path = [System.Environment]::GetEnvironmentVariable("Path","Machine") + ";" + [System.Environment]::GetEnvironmentVariable("Path","User")
    pwsh.exe -c { npm install -g @angular/cli }
}

Export-ModuleMember -Function Install-FrontendTools
