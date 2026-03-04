function Confirm-NetworkConnection
{
    Write-Host "Network bağlantısı kontrol ediliyor..."
	$netAccess = Test-Connection -computer google.com -quiet
    if ($netAccess -eq $false)
    {
        Write-Error "Internet bağlantısı başarısız oldu, lütfen network ayarlarını kontrol edin ve tekrar deneyin."
        break
    }

}

Export-ModuleMember -Function Confirm-NetworkConnection