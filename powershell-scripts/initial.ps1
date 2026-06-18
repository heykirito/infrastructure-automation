$Password = ConvertTo-SecureString "123456" -AsPlainText -Force
$NewUser = "test"
New-LocalUser -Name $NewUser -Password $Password -Description "NewAdminAccount"
Set-LocalUser -Name $NewUser -PasswordNeverExpires $true

net user xyz /passwordchg:no

Add-LocalGroupMember -Group "Administrators" -Member "test"

Disable-LocalUser -Name "OldUserAccount"

Write-Host "Script 1 complete. Please logout and login into user $NewUser to run final script." -ForgroundColor Green
