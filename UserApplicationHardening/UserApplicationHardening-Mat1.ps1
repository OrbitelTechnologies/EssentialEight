﻿# Jerome Ryan - Orbitel Technologies - 21/12/2021
# This script was created to bring users in line with Essential Eight User Application Hardening Maturity Level 1.

#TODO:
#Web browser, Microsoft Office and PDF software security settings cannot be changed by users.
#ACSC or vendor hardening guidance for web browsers, Microsoft Office and PDF software is implemented.
#Maturity Level 1

#Install U-Block Origin in Chrome
cmd -c "reg add "HKEY_LOCAL_MACHINE\SOFTWARE\Policies\Google\Chrome\ExtensionInstallForceList" /v "1" /t REG_SZ /d cjpalhdlnbpafiamejdnhcphjbkeiagm;https://clients2.google.com/service/update2/crx /f"

#Disables Java in Web browser.
(Get-Content C:\Users\$env:USERNAME\AppData\LocalLow\Sun\Java\Deployment\deployment.properties).replace('deployment.webjava.enabled=true', 'deployment.webjava.enabled=false') | Set-Content C:\Users\$env:USERNAME\AppData\LocalLow\Sun\Java\Deployment\deployment.properties

#Internet Explorer 11 is removed. This doesn't work on Windows 11 becuase it doesn't have IE.
Disable-WindowsOptionalFeature -online -FeatureName internet-explorer-optional-amd64

#Maturity Level 2


#Microsoft Office is blocked from creating child processes
Set-MpPreference -AttackSurfaceReductionRules_Ids d4f940ab-401b-4efc-aadc-ad5f3c50688a -AttackSurfaceReductionRules_Actions Enabled

#Block Office applications from creating executable content
Set-MpPreference -AttackSurfaceReductionRules_Ids 3b576869-a4ec-4529-8536-b80a7769e899 -AttackSurfaceReductionRules_Actions Enabled

#Block Office applications from injecting code into other processes
Set-MpPreference -AttackSurfaceReductionRules_Ids 75668c1f-73b5-4cf0-bb93-3ecf5cb7cc84 -AttackSurfaceReductionRules_Actions Enabled

#Block Office applications from injecting code into other processes
Set-MpPreference -AttackSurfaceReductionRules_Ids 75668c1f-73b5-4cf0-bb93-3ecf5cb7cc84 -AttackSurfaceReductionRules_Actions Enabled

#PDF software is blocked from creating child processes
Set-MpPreference -AttackSurfaceReductionRules_Ids 7674ba52-37eb-4a4f-a9a1-f0f9a1619a2c -AttackSurfaceReductionRules_Actions Enabled

#Microsoft Office is configured to prevent activation of OLE packages.
cmd -c "reg add "HKEY_LOCAL_MACHINE\SOFTWARE\Microsoft\Office\ClickToRun\REGISTRY\MACHINE\Software\Microsoft\Office\16.0\access\Security" /v "1" /t REG_DWORD /d 1 /f"
cmd -c "reg add "HKEY_LOCAL_MACHINE\SOFTWARE\Microsoft\Office\ClickToRun\REGISTRY\MACHINE\Software\Microsoft\Office\16.0\excel\Security" /v "2" /t REG_DWORD /d 1 /f"
cmd -c "reg add "HKEY_LOCAL_MACHINE\SOFTWARE\Microsoft\Office\ClickToRun\REGISTRY\MACHINE\Software\Microsoft\Office\16.0\ms project\Security" /v "3" /t REG_DWORD /d 1 /f"
cmd -c "reg add "HKEY_LOCAL_MACHINE\SOFTWARE\Microsoft\Office\ClickToRun\REGISTRY\MACHINE\Software\Microsoft\Office\16.0\outlook\Security" /v "4" /t REG_DWORD /d 1 /f"
cmd -c "reg add "HKEY_LOCAL_MACHINE\SOFTWARE\Microsoft\Office\ClickToRun\REGISTRY\MACHINE\Software\Microsoft\Office\16.0\powerpoint\Security" /v "5" /t REG_DWORD /d 1 /f"
cmd -c "reg add "HKEY_LOCAL_MACHINE\SOFTWARE\Microsoft\Office\ClickToRun\REGISTRY\MACHINE\Software\Microsoft\Office\16.0\publisher\Security" /v "6" /t REG_DWORD /d 1 /f"
cmd -c "reg add "HKEY_LOCAL_MACHINE\SOFTWARE\Microsoft\Office\ClickToRun\REGISTRY\MACHINE\Software\Microsoft\Office\16.0\visio\Security" /v "7" /t REG_DWORD /d 1 /f"
cmd -c "reg add "HKEY_LOCAL_MACHINE\SOFTWARE\Microsoft\Office\ClickToRun\REGISTRY\MACHINE\Software\Microsoft\Office\16.0\word\Security" /v "8" /t REG_DWORD /d 1 /f"

#Blocked PowerShell script executions are logged. Logs to Event Viewer "Applications and Services Logs > PowerShellCore > Operational".
cmd -c "SOFTWARE\Wow6432Node\Policies\Microsoft\Windows\PowerShell\ScriptBlockLogging" /v "EnableScriptBlockLogging" /t REG_DWORD /d 1 /f"

#Maturity Level 3

# .NET Framework 3.5 (includes .NET 2.0 and 3.0) is disabled or removed.

cmd -c "DISM /Online /Disable-Feature /FeatureName:NetFx3"

#Windows PowerShell 2.0 is disabled or removed.
Disable-WindowsOptionalFeature -Online -FeatureName MicrosoftWindowsPowerShellV2Root

#PowerShell is configured to use Constrained Language Mode is dealt with by WDAC.
Set-RuleOption -FilePath "C:\Users\JeromeRyan\Downloads\Policy\Policy\SignedReputable012022.xml" -Option 11 

