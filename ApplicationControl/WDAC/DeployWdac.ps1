Copy-Item -Path "C:\Orbitel\Scripts\E8\WDAC\{126B0167-8054-4F24-9024-B8023B70F707}.cip" -Destination $env:windir+"\System32\CodeIntegrity\CIPolicies\Active\" -Force

& "C:\Orbitel\Scripts\E8\WDAC\RefreshPolicy(AMD64).exe"

