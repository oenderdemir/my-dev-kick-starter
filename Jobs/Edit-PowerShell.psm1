function Edit-PowerShell
{    
    $apps = @(
        @{ name = "JanDeDobbeleer.OhMyPosh" },
        @{ name = "Microsoft.PowerShell" }
    );

    ForEach ($app in $apps) {
        $listApp = (winget list --id $app.name)[-1]
        
        if (![String]::Join("", $listApp).Contains($app.name)) {
            Write-Host  "🧑‍🏭 " $app.name " kuruluyor..."
            winget install -e -h --scope machine --accept-source-agreements --accept-package-agreements --id $app.name
        }
        else {
            Write-Host  "♻️ " $app.name " kurulu guncelleniyor.."
            winget upgrade -e -h --scope machine --accept-source-agreements --accept-package-agreements --id $app.name
        }
    }

    pwsh.exe -Command "Install-Module -Name Terminal-Icons -Repository PSGallery -Scope AllUsers -Force"

    $allUsersProfilePath = $PROFILE.AllUsersAllHosts
    $allUsersProfileFolder = Split-Path -Path $allUsersProfilePath -Parent
    if (!(Test-Path $allUsersProfileFolder -PathType Container)) {
        Write-Host  "👨‍💻 All users profile klasoru olusturuluyor"
        New-Item -ItemType Directory $allUsersProfileFolder -Force | Out-Null
    }

    Copy-Item .\Data\Microsoft.PowerShell_profile.ps1 $allUsersProfilePath -Force
    Write-Host  "🏋️‍♂️ All users config dosyasi olusturuldu"
}

Export-ModuleMember -Function "Edit-PowerShell"
