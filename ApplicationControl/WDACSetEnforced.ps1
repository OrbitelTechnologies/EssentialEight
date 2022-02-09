# Created by Jerome Ryan 09/02/2022 for Orbitel Technologies


Copy-Item "C:\Orbitel\Scripts\E8\WDAC\WDACPolicyAudit.xml" -Destination "C:\Orbitel\Scripts\E8\WDAC\WDACPolicyEnforce.xml"

Set-RuleOption -FilePath "C:\Orbitel\Scripts\E8\WDAC\WDACPolicyEnforce.xml" -Option 3 -Delete # Set from Audit mode to Enforce mode.

#Applies policy to local machine. Downloads the refresh tool, then converts the .XML to .CIP (binary) then enables it.

Invoke-Webrequest "https://github.com/OrbitelTechnologies/EssentialEight/blob/main/ApplicationControl/WDAC/RefreshPolicyAMD64.exe?raw=true" -OutFile "C:\Orbitel\Scripts\E8\WDAC\RefreshPolicyAMD64.exe" }

#Converts to Binary
ConvertFrom-CIPolicy "C:\Orbitel\Scripts\E8\WDAC\WDACPolicyEnforce.xml" "C:\Orbitel\Scripts\E8\WDAC\WDACPolicyEnforce.cip"

Remove-Item $env:windir+"\System32\CodeIntegrity\CIPolicies\Active\WDACPolicyAudit.cip -Force

#Activates Policy by copying to C:\Windows\System32\CodeIntegrity\CIPolicies\Active\, and runing the WDAC Refresh tool.
$PolicyBinary ="C:\Orbitel\Scripts\E8\WDAC\WDACPolicyAudit.cip"
$DestinationFolder = $env:windir+"\System32\CodeIntegrity\CIPolicies\Active\"
$RefreshPolicyTool = "C:\Orbitel\Scripts\E8\WDAC\RefreshPolicyAMD64.exe"
Copy-Item -Path $PolicyBinary -Destination $DestinationFolder -Force
& $RefreshPolicyTool