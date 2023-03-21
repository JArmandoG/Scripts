# Get the Domain's password policy and find out users with passwords older than this value.
#
# This is useful to audit password usage and inconsistencies between policies and enforcements.

# VARIABLES:
$DCserver = "<DC IP>"

# Extract DC Information
$pwdPol = Get-ADDefaultDomainPasswordPolicy -Server $DCserver
$users = Get-ADUser -Server $DCserver -Filter * -Properties PasswordLastSet
$expiredUsers = 0

# Process Information
foreach ($user in $users) {
  $pwdAge = New-TimeSpan -Start $user.PasswordLastSet -End (Get-Date)
  if ($pwdAge -ge $pwdPol.MaxPasswordAge) {
    Write-Host "$($user.Name) has an expired password that was last set on $($user.PasswordLastSet)."
      $expiredUsers += 1
     }
  }

# Print to Stdout the total # of users with Exp Passwords
Write-Host "------------------------------------------------------------------"
Write-Host "Total number of users with expired passwords: $expiredUsers"
