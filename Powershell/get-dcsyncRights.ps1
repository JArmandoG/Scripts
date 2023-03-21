# Get all the objects that have DCSync rights over the domain

$domainServer = "<IP or FQDN of the DC>"
Get-ObjectAcl -DistinguishedName "(Get-ADDomain -Server $domainServer).DistinguishedName -ResolveGUIDs | ?{($_.ObjectType -match 'replication-get') -or ($_.ActiveDirectoryRights -match 'GenericAll') -or ($_.ActiveDirectoryRights -match 'WriteDacl')}
