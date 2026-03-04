function Invoke-FrontendJob
{
    Param(
        [Parameter(Mandatory=$true)][string]$JobFunction,
        [Parameter(Mandatory=$true)][string]$JobName
    )
    Write-Host -ForegroundColor Blue "🎨 Frontend Kurulumu " $JobName " başladı..."
    Invoke-Expression $JobFunction
    Write-Host -ForegroundColor Green "👷‍♂️ Frontend Ortamı Kurulumu " $JobName "bitti..."
}

Get-ChildItem -Recurse *.psm1 | Import-Module -Force

# Frontend Tools
Invoke-FrontendJob -JobFunction "Install-FrontendTools" -JobName "FrontendTools kurulumu"

# NuGet
Invoke-FrontendJob -JobFunction "Install-NugetAndConfigure" -JobName "NuGet kurulumu ve ayarları"
