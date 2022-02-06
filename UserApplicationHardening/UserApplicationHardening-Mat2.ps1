# Jerome Ryan - Orbitel Technologies - 21/12/2021
# This script was created to bring users in line with Essential Eight User Application Hardening Maturity Level 2.

#TODO:
#Web browser, Microsoft Office and PDF software security settings cannot be changed by users.
#ACSC or vendor hardening guidance for web browsers, Microsoft Office and PDF software is implemented.

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



