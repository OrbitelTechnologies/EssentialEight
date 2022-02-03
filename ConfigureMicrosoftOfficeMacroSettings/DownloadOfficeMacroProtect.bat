REM Created by Jerome Ryan 20/01/2022 for Orbitel Technologies

@echo off
mkdir C:\Orbitel\Scripts\E8

powershell -command "& { Invoke-Webrequest "https://raw.githubusercontent.com/OrbitelTechnologies/EssentialEight/main/ConfigureMicrosoftOfficeMacroSettings/OfficeMacroProtect.bat" -OutFile C:\Orbitel\Scripts\E8\OfficeMacroDisable.bat" }"
SCHTASKS /CREATE /SC ONLOGON /TN "Orbitel\OfficeMacroProtect" /F /TR C:\Orbitel\Scripts\E8\OfficeMacroProtect.bat /RU INTERACTIVE /RL HIGHEST
