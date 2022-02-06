REM Created by Jerome Ryan 20/01/2022 for Orbitel Technologies

@echo off
mkdir C:\Orbitel\Scripts\E8

powershell -command "& { Invoke-Webrequest "https://raw.githubusercontent.com/OrbitelTechnologies/EssentialEight/main/UserApplicationHardening/UserApplicationHardening-Mat2.ps1" -OutFile C:\Orbitel\Scripts\E8\UserApplicationHardening-Mat2.ps1" }"
SCHTASKS /CREATE /SC ONLOGON /TN "Orbitel\UserApplicationHardening\MaturityTwo" /F /TR C:\Orbitel\Scripts\E8\UserApplicationHardening-Mat2.ps1 /RU INTERACTIVE /RL HIGHEST
