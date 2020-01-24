Add-Type -AssemblyName 'System.Web'
# creates a variable that stores a string that is password enabled
$password = Get-Content "C:\Users\fdesmet\PycharmProject\guest_portal\static\password.txt"
$secure_password = ConvertTo-SecureString $password -AsPlainText -Force

# creates a login object making it possible to login remotly behind the scenes.
$cred = New-Object System.Management.Automation.PSCredential ("agplastics\administrator", $secure_password)

## this enables remoting on the device where the script is executed.
Enable-PSRemoting -Force
## this sets the computer as a trusted host in the list, this enables communication over the network with Kerberos.
Set-item wsman:localhost\client\trustedhosts -value * -Force
## this invokes a command on multiple remote locations, using the previously created credentials.
invoke-command -ComputerName 'SRV-DC-VS-01' -Credential $cred -scriptblock {
    if (Get-Module -ListAvailable -Name 'sqlserver')
    {
        Import-Module -Name 'sqlserver'
    }
    else
    {
        Install-Module -Name 'sqlserver'
    }


    # Commands to be executed on remote machine
    Add-Type -AssemblyName 'System.Web'
    Enable-PSRemoting -Force
    $json_output = Get-Content -Raw -Path "\\sflpvs01\burotica\ict\#scripts\user_information.json" | ConvertFrom-Json
    $random_password = [System.Web.Security.Membership]::GeneratePassword(8, 0)
    $surname
    $name
    $mail
    $company
    $contact_person
    $number_plate

    function push_query
    {
        param($surname, $name, $mail, $company, $contact_person, $number_plate)
        $insertquery = "insert into PrinterStats ([Surname],[Name],[Mail],[Company],[Contact_Person],[Number_Plate]) values ('$surname', '$name', '$mail', '$company', '$contact_person', '$number_plate')"
        Invoke-SQLcmd -ServerInstance '192.168.64.12\Production' -query $insertquery -U sa -P !Skylux -Database Dashboard
    }

    foreach ($property in $json_output.PSObject.Properties)
    {
        $surname = $property.Value.'surname'
        $name = $property.Value.'name'
        $mail = $property.Value.'mail'
        $company = $property.Value.'company'
        $contact_person = $property.Value.'contact_person'
        $number_plate = $property.Value.'number_plate'
    }

    $principal_name = "$surname.$name"
    $display_name = "$surname $name"

    New-ADUser `
            -SamAccountName $principal_name `
            -UserPrincipalName "$principal_name@agplastics.local" `
            -Name  "$display_name" `
            -GivenName $name `
            -Surname $surname `
            -Enabled $True `
            -PasswordNeverExpires $True `
            -DisplayName $display_name `
            -Description "This user works in $company and is here for $contact_person with the number plate: $number_plate" `
            -Path "OU=Guests,OU=Users,OU=AG Plastics,DC=AgPlastics,DC=local" `
            -AccountPassword (ConvertTo-SecureString $random_password -AsPlainText -Force)

    push_query -surname $surname -name $name -mail $mail -company $company -contact_person $contact_person -number_plate $number_plate

}
