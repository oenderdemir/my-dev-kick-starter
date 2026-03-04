function Install-NugetAndConfigure
{
    $Env:Path = [System.Environment]::GetEnvironmentVariable("Path","Machine") + ";" + [System.Environment]::GetEnvironmentVariable("Path","User")
    $nugetConfigFolder = "C:\ProgramData\NuGet\Config"
    if (!(Test-Path $nugetConfigFolder -PathType Container)) {
        New-Item -Path $nugetConfigFolder -ItemType Directory -Force | Out-Null
    }

    Write-Host "👨‍💻 NuGet Gallery ayarlari yapiliyor..."
    pwsh.exe -c { nuget.exe sources Disable -Name "nuget.org" -ConfigFile "C:\ProgramData\NuGet\Config\NuGet.Config" }
    Write-Host "👷‍♂️ NuGet Gallery ayarlari bitti"
}

Export-ModuleMember -Function Install-NugetAndConfigure
