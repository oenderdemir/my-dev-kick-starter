function Edit-Paths 
{

    Param(
        [Parameter(Mandatory=$true)][string]$FolderToCreate
    )
    
    Write-Host "🐨 $FolderToCreate dosya kontrol ediliyor"
    if ((Test-Path $FolderToCreate -PathType Container)) {
        Write-Host "👽 Eski dosyalar siliniyor"
        Remove-Item -Path $FolderToCreate -Recurse -Force
    }

}

Export-ModuleMember -Function "Edit-Paths"