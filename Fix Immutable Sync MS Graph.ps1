$UPN = Read-Host -Prompt 'Input the UPN'
Import-Module Microsoft.Graph.Users
Connect-MgGraph -Scopes User.ReadWrite.All
Get-MgUser -UserId $UPN | Format-List UserPrincipalName, OnPremisesImmutableId
Invoke-MgGraphRequest -Method PATCH -Uri "https://graph.microsoft.com/v1.0/users/$UPN" -Body @{onPremisesImmutableId = $null}
for ($i = 1; $i -le 100; $i++ ) {
    Write-Progress -Activity "Fixing immutable sync" -Status "$i% Complete:" -PercentComplete $i
    Start-Sleep -Milliseconds 300
}
Get-MgUser -UserId $UPN | Format-List UserPrincipalName, OnPremisesImmutableId
