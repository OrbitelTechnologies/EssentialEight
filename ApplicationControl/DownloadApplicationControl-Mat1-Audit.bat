REM Created by Jerome Ryan 09/02/2022 for Orbitel Technologies

@echo off
mkdir C:\Orbitel\Scripts\E8\WDAC



powershell -command "& { Invoke-Webrequest "https://github.com/OrbitelTechnologies/EssentialEight/raw/main/ApplicationControl/WDAC/DisableControlPanel.ps1" -OutFile "C:\Orbitel\Scripts\E8\WDAC\DisableControlPanel.ps1" } "
powershell -command "& { Invoke-Webrequest "https://github.com/OrbitelTechnologies/EssentialEight/raw/main/ApplicationControl/WDAC/ApplicationControlWorkstation-Mat1-Audit.ps1" -OutFile "C:\Orbitel\Scripts\E8\WDAC\DisableControlPanel.ps1" } "
 
powershell -command "& { Invoke-Webrequest "https://github.com/OrbitelTechnologies/EssentialEight/raw/main/ApplicationControl/WDAC/WDACSetEnforced.ps1" -OutFile "C:\Orbitel\Scripts\E8\WDAC\WDACSetEnforced.ps1" } " 
 
powershell.exe -noexit -file "C:\Orbitel\Scripts\E8\WDAC\ApplicationControlWorkstation-Mat1-Audit.ps1"
powershell.exe -noexit -file "C:\Orbitel\Scripts\E8\WDAC\DisableControlPanel.ps1"

SCHTASKS /CREATE /SC ONLOGON /TN "Orbitel\ApplicationControl" /F /TR C:\Orbitel\Scripts\E8\WDAC\DisableControlPanel.ps1 /RU INTERACTIVE /RL HIGHEST