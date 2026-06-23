$isAdmin = ([Security.Principal.WindowsPrincipal][Security.Principal.WindowsIdentity]::GetCurrent()).IsInRole([Security.Principal.WindowsBuiltInRole]::Administrator)

if ($isAdmin) {
    Write-Host "Running with admin privileges." -ForegroundColor Red 
} else {
    Write-Warning "Run with admin privileges, exiting."
    Exit
}

$Newuser = Read-Host -Prompt "Please enter the username: "

while (Get-LocalUser -Name $NewUser -ErrorAction SilentlyContinue) {
    Write-Host ""
    Write-Host "The username already exists"

    $NewUser = Read-Host -Prompt "Enter a different username"
  }

$Password = ConvertTo-SecureString "123456" -AsPlainText -Force
Write-Host "Using default password" -ForegroundColor Green

New-LocalUser -Name $NewUser -Password $Password -Description "NewAdminAccount"
Write-Host "New Account created" -ForegroundColor Green 

Set-LocalUser -Name $NewUser -PasswordNeverExpires $true
Write-Host "Set password to never expire" -ForegroundColor Green

net user $NewUser /passwordchg:no
Write-Host "Password change disabled" -ForegroundColor Green

Add-LocalGroupMember -Group "Administrators" -Member $NewUser
Write-Host "Added to admin group" -ForegroundColor Green

$PromptResponse = Read-Host -Prompt "Do you want to disable current user? (Y/n): "
if ($PromptResponse -eq 'Y','y','yes') {
  $CurrentUser = $env:username
  Disable-LocalUser -Name $CurrentUser
  Write-Host "Disbled current account" -ForegroundColor Green
}

Write-Host "Script 1 complete. Please logout and login into user '$NewUser' to run final script." -ForegroundColor Green
