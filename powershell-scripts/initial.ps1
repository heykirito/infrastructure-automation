$Password = ConvertTo-SecureString "123456" -AsPlainText -Force
$NewUser = "test"

New-LocalUser -Name $NewUser -Password $Password -Description "NewAdminAccount"
Write-Host "New Account created" -ForegroundColor Green 

Set-LocalUser -Name $NewUser -PasswordNeverExpires $true
Write-Host "Set password to never expire" -ForegroundColor Green

net $NewUser xyz /passwordchg:no
Write-Host "Password change disabled" -ForegroundColor Green

Add-LocalGroupMember -Group "Administrators" -Member $NewUser
Write-Host "Added to admin group" -ForegroundColor Green

Disable-LocalUser -Name "OldUserAccount"
Write-Host "Disbled current account" -ForegroundColor Green

Write-Host "Script 1 complete. Please logout and login into user $NewUser to run final script." -ForegroundColor Green
