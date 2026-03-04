function Register-FolderViewOptions
{
    
    Write-Host "📐 Folder view ayarları yapılıyor..."
    $key = "HKCU:\Software\Microsoft\Windows\CurrentVersion\Explorer\Advanced"
    $explorerRestartNeeded = $false
    if ( (Get-ItemProperty $key Hidden).Hidden -ne 1) 
    {
        Set-ItemProperty $key Hidden 1
        $explorerRestartNeeded = $true;
    }
    if ( (Get-ItemProperty $key HideFileExt).HideFileExt -ne 0) 
    {
        Set-ItemProperty $key HideFileExt 0
        $explorerRestartNeeded = $true;
    }
    if ($explorerRestartNeeded)
    {
        Stop-Process -processname explorer
    }
    Write-Host "👌 Folder view ayarları bitti."
}

Export-ModuleMember -Function Register-FolderViewOptions