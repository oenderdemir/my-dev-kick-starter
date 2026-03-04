function Install-wsl
{
    Write-Host "🐧 wsl kuruluyor"
    wsl --install

    $appName = "Docker.DockerDesktop" 
    $listApp = (winget list --id $appName)[-1]
    
    if (![String]::Join("", $listApp).Contains($appName)) {
        Write-Host "🚢 " $appName  " kuruluyor"
        winget install -e -h --scope machine --accept-source-agreements --accept-package-agreements --id $appName
    }
    else {
        Write-Host "♻️ " $appName " kurulu guncelleniyor.."
        winget upgrade -e -h --scope machine --accept-source-agreements --accept-package-agreements --id $appName
    }
}

Export-ModuleMember -Function Install-wsl
