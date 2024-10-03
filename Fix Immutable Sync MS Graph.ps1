$UPN = Read-Host -Prompt 'Input the UPN'
Import-Module Microsoft.Graph
Connect-MgGraph -Scopes User.Read.All
Get-MgUser -UserId $UPN | Format-List UserPrincipalName, OnPremisesImmutableId
Invoke-MgGraphRequest -Method PATCH -Uri "v1.0/users/$UPN" -Body @{onPremisesImmutableId = $null}
for ($i = 1; $i -le 100; $i++ ) {
    Write-Progress -Activity "Fixing immutable sync" -Status "$i% Complete:" -PercentComplete $i
    Start-Sleep -Milliseconds 300
}
Get-MgUser -UserId $UPN | Format-List UserPrincipalName, OnPremisesImmutableId
