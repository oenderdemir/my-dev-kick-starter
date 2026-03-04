function Confirm-SystemLocale
{
	Write-Host "Sistem locale kontrol ediliyor"
	$locale = (Get-WinSystemLocale).Name.ToLower()
    if ($locale -ne "en-us" -and $locale -ne "en-gb" -and $locale -ne "en")
    {
        Write-Host "Locale İngilizce değil ($locale), locale ayarlanıyor..."
        Set-WinSystemLocale -SystemLocale "en-US"
        Write-Host "Locale düzeltildi."
        return $true
    }
    else
    {
        Write-Host "Locale ($locale) uygun."
        return $false
    }
}

Export-ModuleMember -Function Confirm-SystemLocale
