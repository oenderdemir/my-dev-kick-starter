function Install-Applications 
{
    
    Write-Output "🛫 Programlar Kuruluyor"

    $apps = @(
        @{ name = "Microsoft.PowerShell" },
        @{ name = "EclipseAdoptium.Temurin.8.JDK" },
        @{ name = "EclipseAdoptium.Temurin.11.JDK" },
        @{ name = "EclipseAdoptium.Temurin.17.JDK" },
        @{ name = "EclipseAdoptium.Temurin.21.JDK" },
        @{ name = "EclipseAdoptium.Temurin.25.JDK" },
        @{ name = "JetBrains.Toolbox" },
        @{ name = "SublimeHQ.SublimeText.4" },
        @{ name = "Notepad++.Notepad++" },
        @{ name = "Insomnia.Insomnia" },
        @{ name = "Google.Chrome" },
        @{ name = "Opera.OperaGX" },
        @{ name = "Mozilla.Firefox.DeveloperEdition" },
        @{ name = "Git.Git" },
        @{ name = "CoreyButler.NVMforWindows" },
        @{ name = "Yarn.Yarn" },
        @{ name = "7zip.7zip" }
    );

    ForEach ($app in $apps) {
        $listApp = (winget list --id $app.name)[-1]
        
        if (![String]::Join("", $listApp).Contains($app.name)) {
            Write-Host "🧑‍🏭 " $app.name " kuruluyor"
            winget install -e -h --scope machine --accept-source-agreements --accept-package-agreements --id $app.name
        }
        else {
            Write-Host "♻️ " $app.name " kurulu guncelleniyor.."
            winget upgrade -e -h --scope machine --accept-source-agreements --accept-package-agreements --id $app.name
        }
    }
    
}

Export-ModuleMember -Function Install-Applications
