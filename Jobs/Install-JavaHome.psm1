function Get-TemurinJdkPath
{
    Param(
        [Parameter(Mandatory = $true)][int]$Major
    )

    $rootPath = "C:\Program Files\Eclipse Adoptium"
    if (!(Test-Path $rootPath -PathType Container)) {
        return $null
    }

    $jdkFolder = Get-ChildItem -Path $rootPath -Directory -ErrorAction SilentlyContinue |
        Where-Object { $_.Name -like "jdk-$Major*" } |
        Sort-Object Name -Descending |
        Select-Object -First 1

    if ($null -eq $jdkFolder) {
        return $null
    }

    return $jdkFolder.FullName
}

function Install-JavaHome
{
    $javaVersions = @(8, 11, 17, 21, 25)
    $foundHomes = @{}

    foreach ($version in $javaVersions) {
        $jdkPath = Get-TemurinJdkPath -Major $version
        $varName = "JAVA$($version)_HOME"

        if ([string]::IsNullOrWhiteSpace($jdkPath)) {
            Write-Warning "$varName ayarlanamadi. Temurin $version JDK bulunamadi."
            continue
        }

        [Environment]::SetEnvironmentVariable($varName, $jdkPath, "Machine")
        $foundHomes[$varName] = $jdkPath
        Write-Host "🐨 $varName ayarlandi: $jdkPath"
    }

    $defaultJavaHome = $null
    foreach ($version in @(25, 21, 17, 11, 8)) {
        $candidate = "JAVA$($version)_HOME"
        if ($foundHomes.ContainsKey($candidate)) {
            $defaultJavaHome = $foundHomes[$candidate]
            break
        }
    }

    if ([string]::IsNullOrWhiteSpace($defaultJavaHome)) {
        Write-Warning "JAVA_HOME ayarlanamadi. Desteklenen Java surumlerinden hicbiri bulunamadi."
        return
    }

    [Environment]::SetEnvironmentVariable("JAVA_HOME", $defaultJavaHome, "Machine")

    $machinePathItems = @(([Environment]::GetEnvironmentVariable("Path", "Machine") -split ';') | Where-Object { $_ -ne "" })
    if ($machinePathItems -contains "%JAVA_HOME%\\bin") {
        Write-Host "🐨 JAVA_HOME ayarli tesekkurler"
    }
    else {
        Write-Host "👽 JAVA_HOME ayarlaniyor"
        $oldPath = [Environment]::GetEnvironmentVariable("Path", "Machine") + ";%JAVA_HOME%\bin"
        [Environment]::SetEnvironmentVariable("Path", $oldPath, "Machine")
    }
}

Export-ModuleMember -Function Install-JavaHome
