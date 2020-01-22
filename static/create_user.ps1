#Add-Type -AssemblyName 'System.Web'
## creates a variable that stores a string that is password enabled
#$password = Get-Content password.txt | ConvertTo-SecureString
## creates a login object making it possible to login remotly behind the scenes.
#$cred = New-Object System.Management.Automation.PSCredential ("agplastics\administrator", $password)

$json_output = Get-Content -Raw -Path C:\Users\fdesmet\PycharmProject\guest_portal\user_information.json | ConvertFrom-Json

Write-Output $json_output.frederik.surname

## this enables remoting on the device where the script is executed.
#Enable-PSRemoting
## this sets the computer as a trusted host in the list, this enables communication over the network with Kerberos.
#Set-item wsman:localhost\client\trustedhosts -value * -Force
## this invokes a command on multiple remote locations, using the previously created credentials.
#invoke-command -ComputerName 'SRV-DC-VS-01' -Credential $cred -scriptblock {
#    # Commands to be executed on remote machine
#    Add-Type -AssemblyName 'System.Web'
#    $random_password = [System.Web.Security.Membership]::GeneratePassword(8, 0)
#
#    New-ADUser `
#            -SamAccountName guest1.test `
#            -UserPrincipalName "guest1.test@agplastics.local" `
#            -Name  "guest1 test" `
#            -GivenName guest1 `
#            -Surname test `
#            -Enabled $True `
#            -DisplayName "guest1 test" `
#            -Description "temp guest user" `
#            -Path "OU=Guests,OU=Users,OU=AG Plastics,DC=AgPlastics,DC=local" `
#            -AccountPassword (ConvertTo-SecureString $random_password -AsPlainText -Force)
#}
#
