function Invoke-KickstartJob
{
    Param(
        [Parameter(Mandatory=$true)][string]$JobFunction,
        [Parameter(Mandatory=$true)][string]$JobName,
        [Parameter(Mandatory=$false)][int]$ProgressIncrement = 8
    )
    Write-Host -ForegroundColor Blue "💻 Development Ortamı Kurulumu " $JobName " başladı..."
    Invoke-Expression $JobFunction
    [int]$global:Progress = [int]$global:Progress + [int]$ProgressIncrement
    Write-Host -ForegroundColor Green "👷‍♂️ Development Ortamı Kurulumu " $JobName "bitti..."
}
#############################################################
#
# Bu script in kurduğu programların bazılarının mutlaka kurulması istenmektedir ve kullanıcıya sormadan kurulur,
# bazı programlar ise opsiyoneldir ve kullanıcıya sorularak kurulur.
#
# Güncelleme işi de şu şekilde yapılır. Bazı programlar kendilerini güncelledikleri için script tarafından güncelleme işlemi yapılmaz,
# Bazı programlar ise güncel kullanılması önemli olduğundan, kullanıcıya sorulmadan güncellenir.
# Diğer programlar ise güncelleme yapılmadan önce kullanıcıya sorulur.
#
#############################################################
# Modules
Get-ChildItem -Recurse *.psm1 | Import-Module -Force

# Global variables
[int]$global:Progress = 0

Invoke-KickstartJob -JobFunction "Edit-PowerShell" -JobName "Edit-PowerShell"
# Change locale to English
Confirm-SystemLocale
# Network Check
Confirm-NetworkConnection

# Kurulum adımları
Invoke-KickstartJob -JobFunction "Start-GPUpdate" -JobName "Group policy update"
# Register folder view options
Invoke-KickstartJob -JobFunction "Register-FolderViewOptions" -JobName "Folder view ayarları"
#
#Install Applications
Invoke-KickstartJob -JobFunction "Install-Applications" -JobName "Programlar Kuruluyor kurulumu"
#
#Install Windows Applications
Invoke-KickstartJob -JobFunction "Install-WindowsApps" -JobName "Windows Programlari Kuruluyor kurulumu"
#
# JDK
# SQLServer Native Auth Library
Invoke-KickstartJob -JobFunction "Install-SQLServerNaviteAuth" -JobName "SQL Server Integrated Authentication Library kurulumu"

# JAVA_HOME
Invoke-KickstartJob -JobFunction "Install-JavaHome" -JobName "Java Home ayarlaniyor"

# NuGet-CLI
Invoke-KickstartJob -JobFunction "Install-NuGet-CLI" -JobName "NuGet-CLI kurulumu"

# Maven
Invoke-KickstartJob -JobFunction "Install-Maven" -JobName "Maven kurulumu"

# Gradle
Invoke-KickstartJob -JobFunction "Install-Gradle" -JobName "Gradle kurulumu"

# Helm
Invoke-KickstartJob -JobFunction "Install-Helm" -JobName "Helm kurulumu"

# Fonts
Invoke-KickstartJob -JobFunction "InstallFonts" -JobName "Fontlar kuruluyor"

# Other programs

# WSL
Invoke-KickstartJob -JobFunction "Install-wsl" -JobName "wsl kurulumu"

# Son
Write-Host "👷‍♂️ Development Ortamı Kurulumu bitti"
