# Export Inactive Users from 6 to 12 months to Stdout, add a count at stdout, and export the results to CSV for management.

# VARIABLES:
$ServerDC = "<Domain Controller IP>"
$ExportPath = "InactiveUsers.csv" # (Change this variable if necessary; its generation will be in $PWD)

# Set 6 and 12 months as a reference
$SixMonthsAgo = (Get-Date).AddMonths(-6)
$TwelveMonthsAgo = (Get-Date).AddMonths(-12)

# Get information from the domain
$InactiveUsers = Get-ADUser -Server $ServerDC -Filter {Enabled -eq $true} -Properties LastLogonDate, DisplayName, EmailAddress, LastLogonTimeStamp | Where-Object { $_.LastLogonDate -lt $SixMonthsAgo }
$UserList = @()

# Process each object
foreach ($user in $InactiveUsers) {
    $InactiveDuration = ""

    if ($user.LastLogonDate -lt $TwelveMonthsAgo) {
        $InactiveDuration = "12+ Months"
    } else {
        $InactiveDuration = "6-12 Months"
    }

    $UserList += [PSCustomObject]@{
        DisplayName     = $user.DisplayName
        EmailAddress    = $user.EmailAddress
        LastLogonDate   = $user.LastLogonDate
        InactiveDuration = $InactiveDuration
    }
}

$UserList | Format-Table -AutoSize

$TotalInactiveUsers = $InactiveUsers.Count
Write-Host "------------------------------------------------------------------------"
Write-Host "[i] Total number of inactive users: $TotalInactiveUsers"

# Export to CSV
$UserList | Export-Csv -Path $ExportPath -NoTypeInformation
Write-Host "[+] Results exported to $ExportPath"
