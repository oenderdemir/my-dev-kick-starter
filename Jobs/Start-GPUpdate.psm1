function Start-GPUpdate
{
    Write-Host "Group policy update ediliyor..."
    gpupdate /force /target:computer 
}

Export-ModuleMember -Function Start-GPUpdate