REM Created by Jerome Ryan 20/01/2022 for Orbitel Technologies

mkdir C:\Orbitel\Scripts\E8

powershell -command "& { Invoke-Webrequest "https://github.com/OrbitelTechnologies/EssentialEight/blob/e16bccf59056c1307d5380cbbbb69057da8d0b24/Configure%20Microsoft%20Office%20macro%20settings/OfficeMacroDisable.bat" -OutFile C:\Orbitel\Scripts\E8\OfficeMacroDisable.bat" }"
SCHTASKS /CREATE /SC ONLOGON /TN "Orbitel\OfficeMacroDisable" /F /TR C:\Orbitel\Scripts\E8\OfficeMacroDisable.bat /RU Users
