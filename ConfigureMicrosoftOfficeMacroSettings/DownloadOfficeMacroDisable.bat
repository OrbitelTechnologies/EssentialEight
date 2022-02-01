REM Created by Jerome Ryan 20/01/2022 for Orbitel Technologies

@echo off
mkdir C:\Orbitel\Scripts\E8

powershell -command "& { Invoke-Webrequest "https://raw.githubusercontent.com/OrbitelTechnologies/EssentialEight/main/ConfigureMicrosoftOfficeMacroSettings/OfficeMacroDisable.bat" -OutFile C:\Orbitel\Scripts\E8\OfficeMacroDisable.bat" }"
SCHTASKS /CREATE /SC ONLOGON /TN "Orbitel\OfficeMacroDisable" /F /TR C:\Orbitel\Scripts\E8\OfficeMacroDisable.bat /RU INTERACTIVE /RL HIGHEST
