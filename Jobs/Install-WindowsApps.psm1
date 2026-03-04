function Install-WindowsApps {
    
    Write-Output "🚌 Programlar Kuruluyor"

    $apps = @(
        @{ name = "Microsoft.DotNet.SDK.3_1" },
        @{ name = "Microsoft.DotNet.SDK.6" },
        @{ name = "Microsoft.DotNet.SDK.7" },
        @{ name = "Microsoft.SQLServerManagementStudio.22" },
        @{ name = "Microsoft.VisualStudioCode" },
        @{ name = "Microsoft.VisualStudio.2022.Enterprise" },
        @{ name = "Microsoft.DotNet.SDK.8" },
        @{ name = "Microsoft.DotNet.SDK.9" },
        @{ name = "Microsoft.DotNet.SDK.10" }
    );

    ForEach ($app in $apps) {
        $listApp = (winget list --id $app.name)[-1]
        
        if (![String]::Join("", $listApp).Contains($app.name)) {
            Write-Host  "🧑‍🏭 " $app.name " kuruluyor"
            winget install -e -h --scope machine --accept-source-agreements --accept-package-agreements --id $app.name
        }
        else {
            Write-Host  "♻️ " $app.name " kurulu guncelleniyor.."
            winget upgrade -e -h --scope machine --accept-source-agreements --accept-package-agreements --id $app.name
        }
    }
    
}

Export-ModuleMember -Function Install-WindowsApps
