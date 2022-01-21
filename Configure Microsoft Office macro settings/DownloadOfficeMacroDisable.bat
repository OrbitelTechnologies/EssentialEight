REM Created by Jerome Ryan 20/01/2022 for Orbitel Technologies

mkdir C:\Orbitel\Scripts\E8

powershell -command "& { Invoke-Webrequest "https://github.com/OrbitelTechnologies/EssentialEight/blob/541882f6132d84a1537628188660e02c3c53f29f/OfficeMacroDisable.bat" -OutFile C:\Orbitel\Scripts\E8\OfficeMacroDisable.bat" }"
SCHTASKS /CREATE /SC ONLOGON /TN "Orbitel\OfficeMacroDisable" /F /TR C:\Orbitel\Scripts\E8\OfficeMacroDisable.bat /RU Users
