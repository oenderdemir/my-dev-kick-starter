function Install-SQLServerNaviteAuth
{
    Copy-Item .\Data\sqljdbc_auth.dll C:\Windows
}

Export-ModuleMember -Function "Install-SQLServerNaviteAuth"
