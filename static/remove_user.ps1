Import-Module activedirectory
Add-Type -AssemblyName 'System.Web'
# creates a variable that stores a string that is password enabled
$password = Get-Content password.txt | ConvertTo-SecureString
# creates a login object making it possible to login remotly behind the scenes.
$cred = New-Object System.Management.Automation.PSCredential ("agplastics\administrator", $password)

# this enables remoting on the device where the script is executed.
Enable-PSRemoting
# this sets the computer as a trusted host in the list, this enables communication over the network with Kerberos.
Set-item wsman:localhost\client\trustedhosts -value * -Force
# this invokes a command on multiple remote locations, using the previously created credentials.
invoke-command -ComputerName 'SRV-DC-VS-01' -Credential $cred -scriptblock {
    # Commands to be executed on remote machine
    $all_guest_users = Get-ADUser -SearchBase "OU=Guests, OU=Users, OU=AG Plastics, DC=AgPlastics, DC=local" -Filter * -Properties MemberOf

    ForEach ($user in $all_guest_users)
    {
        remove-aduser $user -confirm:$false
    }
}
