REM Created by Jerome Ryan 20/01/2022 for Orbitel Technologies

mkdir C:\Orbitel\Scripts\E8

powershell -command "& { Invoke-Webrequest "https://raw.githubusercontent.com/OrbitelTechnologies/EssentialEight/main/UserApplicationHardening/UserApplicationHardening-Mat1.ps1" -OutFile C:\Orbitel\Scripts\E8\UserApplicationHardening-Mat1.ps1" }"
SCHTASKS /CREATE /SC ONLOGON /TN "Orbitel\UserApplicationHardening\MaturityOne" /F /TR C:\Orbitel\Scripts\E8\UserApplicationHardening-Mat1.ps1 /RU Users /RL HIGHEST
