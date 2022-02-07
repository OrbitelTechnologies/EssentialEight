
mkdir "C:\Orbitel\Scripts\E8\WDAC"

#Enable Windows Defender Application Control
cmd -c "reg add "HKEY_LOCAL_MACHINE\SOFTWARE\Policies\Microsoft\Windows\DeviceGuard" /v "DeployConfigCIPolicy" /t REG_DWORD /d 1 /f"

#Enable Virtualization Based Security
cmd -c "reg add "HKEY_LOCAL_MACHINE\SOFTWARE\Policies\Microsoft\Windows\DeviceGuard" /v "EnableVirtualizationBasedSecurity" /t REG_DWORD /d 1 /f"

Copy-Item "%windir%\schemas\CodeIntegrity\ExamplePolicies\DefaultWindows_Audit.xml" -Destination "C:\Orbitel\Scripts\E8\WDAC"

$WDACPolicy = "C:\Orbitel\Scripts\E8\WDAC\DefaultWindows_Audit.xml"
Set-RuleOption -FilePath $WDACPolicy -Option 0 # Enabled UMCI
Set-RuleOption -FilePath $WDACPolicy -Option 1 # Enable Boot Menu Protection
Set-RuleOption -FilePath $WDACPolicy -Option 2 # Require WHQL
Set-RuleOption -FilePath $WDACPolicy -Option 3 # Enable Audit Mode
Set-RuleOption -FilePath $WDACPolicy -Option 4 # Disable Flight Signing
Set-RuleOption -FilePath $WDACPolicy -Option 6 # Enable Unsigned Policy
Set-RuleOption -FilePath $WDACPolicy -Option 8 # Require EV Signers
Set-RuleOption -FilePath $WDACPolicy -Option 10 # Enable Boot Audit on Failure
Set-RuleOption -FilePath $WDACPolicy -Option 12 # Enable Enforce Store Apps
Set-RuleOption -FilePath $WDACPolicy -Option 13 # Enable Managed Installer
Set-RuleOption -FilePath $WDACPolicy -Option 16 # Enable No Reboot
Set-RuleOption -FilePath $WDACPolicy -Option 17 # Enable Allow Supplemental
Set-RuleOption -FilePath $WDACPolicy -Option 19 # Enable Dynamic Code Security