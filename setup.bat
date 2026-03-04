@ECHO OFF
chcp 65001 >nul
echo 🚀 Script admin olarak çalıştırılmalıdır. Yetkiler kontrol ediliyor..
fltmc >nul 2>&1
if %errorLevel% neq 0 (
    echo 🔐 Admin yetkisi yok. UAC ile yeniden başlatılıyor...
    powershell -NoProfile -ExecutionPolicy Bypass -Command "Start-Process -FilePath '%~f0' -Verb RunAs"
    exit /b
)

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
PAUSE
