# Created by Jerome Ryan 09/02/2022 for Orbitel Technologies


mkdir "C:\Orbitel\Scripts\E8\WDAC"

#Enable Windows Defender Application Control
cmd -c "reg add "HKEY_LOCAL_MACHINE\SOFTWARE\Policies\Microsoft\Windows\DeviceGuard" /v "DeployConfigCIPolicy" /t REG_DWORD /d 1 /f"

#Enable Virtualization Based Security
cmd -c "reg add "HKEY_LOCAL_MACHINE\SOFTWARE\Policies\Microsoft\Windows\DeviceGuard" /v "EnableVirtualizationBasedSecurity" /t REG_DWORD /d 1 /f"

#Copies Default WDAC template to Orbitel folder.
Copy-Item -Path "%windir%\schemas\CodeIntegrity\ExamplePolicies\DefaultWindows_Audit.xml" -Destination "C:\Orbitel\Scripts\E8\WDAC\WDACPolicyAudit.xml"

#Set WDAC policy rules. Find explanations here: https://docs.microsoft.com/en-us/windows/security/threat-protection/windows-defender-application-control/select-types-of-rules-to-create
$WDACPolicy = "C:\Orbitel\Scripts\E8\WDAC\WDACPolicyAudit.xml"
Set-RuleOption -FilePath $WDACPolicy -Option 0 # Enabled UMCI
Set-RuleOption -FilePath $WDACPolicy -Option 1 # Enable Boot Menu Protection
Set-RuleOption -FilePath $WDACPolicy -Option 2 # Require WHQL
Set-RuleOption -FilePath $WDACPolicy -Option 3 # Enable Audit Mode
Set-RuleOption -FilePath $WDACPolicy -Option 4 # Disable Flight Signing
Set-RuleOption -FilePath $WDACPolicy -Option 6 # Enable Unsigned Policy
Set-RuleOption -FilePath $WDACPolicy -Option 8 # Require EV Signers
Set-RuleOption -FilePath $WDACPolicy -Option 9 # Enable Advanced Boot Options Menu
Set-RuleOption -FilePath $WDACPolicy -Option 10 # Enable Boot Audit on Failure
Set-RuleOption -FilePath $WDACPolicy -Option 12 # Enable Enforce Store Apps
Set-RuleOption -FilePath $WDACPolicy -Option 13 # Enable Managed Installer
Set-RuleOption -FilePath $WDACPolicy -Option 16 # Enable No Reboot
Set-RuleOption -FilePath $WDACPolicy -Option 17 # Enable Allow Supplemental
Set-RuleOption -FilePath $WDACPolicy -Option 19 # Enable Dynamic Code Security

#Set file path rules. This allows scripts,executables etc to run from this location (unless -Deny option is set)
$rules = New-CIPolicyRule -FilePathRule C:\ProgramFiles\*
$rules += New-CIPolicyRule -FilePathRule C:\ProgramFiles(x86)\*
$rules += New-CIPolicyRule -FilePathRule C:\Windows\
$rules += New-CIPolicyRule -FilePathRule C:\Windows\System32\Microsoft\Crypto\RSA\MachineKeys\* -Deny
$rules += New-CIPolicyRule -FilePathRule C:\Windows\System32\spool\drivers\color\* -Deny
$rules += New-CIPolicyRule -FilePathRule C:\Windows\System32\Tasks\* -Deny
$rules += New-CIPolicyRule -FilePathRule C:\Windows\Tasks\* -Deny
$rules += New-CIPolicyRule -FilePathRule C:\Windows\Temp\* -Deny
$rules += New-CIPolicyRule -FilePathRule C:\Users\* -Deny

# Allows our scripts to run
$rules += New-CIPolicyRule -FilePathRule C:\Orbitel\*

#Merges policy into one.
New-CIPolicy -MultiplePolicyFormat -FilePath "C:\Orbitel\Scripts\E8\WDAC\WDACPolicyAudit.xml" -Rules $Rules

#Applies policy to local machine.
#Downloads the refresh tool, then converts the .XML to .CIP (binary) then enables it with the refresh tool.

Invoke-Webrequest "https://github.com/OrbitelTechnologies/EssentialEight/blob/main/ApplicationControl/WDAC/RefreshPolicyAMD64.exe?raw=true" -OutFile "C:\Orbitel\Scripts\E8\WDAC\RefreshPolicyAMD64.exe" }

#Converts to Binary
ConvertFrom-CIPolicy "C:\Orbitel\Scripts\E8\WDAC\WDACPolicyAudit.xml" "C:\Orbitel\Scripts\E8\WDAC\WDACPolicyAudit.cip"

#Activates Policy by copying to C:\Windows\System32\CodeIntegrity\CIPolicies\Active\, and runing the WDAC Refresh tool.
$PolicyBinary ="C:\Orbitel\Scripts\E8\WDAC\WDACPolicyAudit.cip"
$DestinationFolder = $env:windir+"\System32\CodeIntegrity\CIPolicies\Active\"
$RefreshPolicyTool = "C:\Orbitel\Scripts\E8\WDAC\RefreshPolicyAMD64.exe"
Copy-Item -Path $PolicyBinary -Destination $DestinationFolder -Force
& $RefreshPolicyTool

