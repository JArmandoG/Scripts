# Get all the objects that have DCSync rights over the domain

# REQUIRES POWERVIEW.ps1 - https://github.com/PowerShellMafia/PowerSploit/blob/master/Recon/PowerView.ps1

$domainServer = "<IP or FQDN of the DC>"
Get-ObjectAcl -DistinguishedName "(Get-ADDomain -Server $domainServer).DistinguishedName -ResolveGUIDs | ?{($_.ObjectType -match 'replication-get') -or ($_.ActiveDirectoryRights -match 'GenericAll') -or ($_.ActiveDirectoryRights -match 'WriteDacl')}
