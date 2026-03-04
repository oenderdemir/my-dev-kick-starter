@ECHO OFF
chcp 65001 >nul
echo 🚀 Script admin olarak çalıştırılmalıdır. Yetkiler kontrol ediliyor..
net session >nul 2>&1
if %errorLevel% == 0 (
    echo 🤵‍♂️ Admin yetkileri doğrulandı.

    echo 💪 Powershell 7 kuruluyor...
    winget install -e -h --scope machine --accept-source-agreements --accept-package-agreements --id Microsoft.PowerShell

    cd %~dp0
    echo ♻️ Ortam değişkenleri güncelleniyor
    .\refresh.cmd
    echo 🏃 Kurulum başlatıldı..
    pwsh -executionpolicy bypass -File ".\MyKickstarter.ps1"
    .\refresh.cmd
    pwsh -executionpolicy bypass -File ".\FrontendJobs.ps1"
    shutdown /r /t 5
) else (
	echo ================================================================================
    echo =================              🚨 HATA !!! 🚨                   ===============
    echo ================================================================================
    echo 	  🚫 Admin yetkileri bulunamadı. Lütfen script i admin olarak çalıştırınız. 
    echo                     ^(Sağ click - Run as Administrator^)
    echo ================================================================================
)
PAUSE
