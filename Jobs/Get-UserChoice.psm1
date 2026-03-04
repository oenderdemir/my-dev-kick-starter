function Get-UserChoice
{
    Param(
        [Parameter(Mandatory=$true)][string]$Title, 
        [Parameter(Mandatory=$true)][string]$Message, 
        [Parameter(Mandatory=$false)][string]$FirstChoice = "&Evet",
        [Parameter(Mandatory=$false)][string]$FirstChoiceDesc = "Evet",
        [Parameter(Mandatory=$false)][string]$SecondChoice = "&Hayır",
        [Parameter(Mandatory=$false)][string]$SecondChoiceDesc = "Hayır"
    )
    $firstChoiceObject = New-Object System.Management.Automation.Host.ChoiceDescription $FirstChoice, $FirstChoiceDesc
    $secondChoiceObject = New-Object System.Management.Automation.Host.ChoiceDescription $SecondChoice, $SecondChoiceDesc
    $options = [System.Management.Automation.Host.ChoiceDescription[]]($firstChoiceObject, $secondChoiceObject)
    $result = $host.ui.PromptForChoice($Title, $Message, $options, 0)
    return $result
}

function Read-Email
{
    $email = Read-Host "Email adresiniz?"
    return $email
}



Export-ModuleMember -Function Get-UserChoice, Read-Email