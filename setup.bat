@ECHO OFF
chcp.com 65001
echo Script admin olarak calistirilmalidir. Yetkiler kontrol ediliyor...
powershell -NoProfile -ExecutionPolicy Bypass -Command "$p=[Security.Principal.WindowsPrincipal][Security.Principal.WindowsIdentity]::GetCurrent(); $adminSid=New-Object Security.Principal.SecurityIdentifier('S-1-5-32-544'); if($p.IsInRole($adminSid)){exit 0}else{exit 1}"
if %errorLevel% neq 0 (
    echo Admin yetkisi yok. UAC ile yeniden baslatiliyor...
    powershell -NoProfile -ExecutionPolicy Bypass -Command "Start-Process -FilePath '%~f0' -Verb RunAs"
    exit /b
)

echo Admin yetkileri dogrulandi.

echo Powershell 7 kuruluyor...
winget install -e -h --scope machine --accept-source-agreements --accept-package-agreements --id Microsoft.PowerShell

cd %~dp0
echo Ortam degiskenleri guncelleniyor...
.\refresh.cmd
echo Kurulum baslatildi...
pwsh -executionpolicy bypass -File ".\MyKickstarter.ps1"
.\refresh.cmd
pwsh -executionpolicy bypass -File ".\FrontendJobs.ps1"
shutdown /r /t 5
PAUSE
