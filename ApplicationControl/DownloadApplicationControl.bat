REM Created by Jerome Ryan 20/01/2022 for Orbitel Technologies

mkdir C:\Orbitel\Scripts\E8\WDAC

powershell -command "& { Invoke-Webrequest "https://github.com/OrbitelTechnologies/EssentialEight/blob/bcb2048971032dc3b0969b2022622dd10c1b8472/ApplicationControl/WDAC/Policy.zip" -OutFile "C:\Orbitel\Scripts\E8\WDAC\Policy.zip"}"
powershell -command "& { Expand-Archive "C:\Orbitel\Scripts\E8\WDAC\Policy.zip" -DestinationPath "C:\Orbitel\Scripts\E8\WDAC\Policy" -Force }"
powershell -command "& { Invoke-Webrequest "https://github.com/OrbitelTechnologies/EssentialEight/blob/bcb2048971032dc3b0969b2022622dd10c1b8472/ApplicationControl/WDAC/DeployWdac.ps1" -OutFile "C:\Orbitel\Scripts\E8\WDAC\DeployWdac.ps1" }"
powershell -command "& { Invoke-Webrequest "https://github.com/OrbitelTechnologies/EssentialEight/blob/bcb2048971032dc3b0969b2022622dd10c1b8472/ApplicationControl/WDAC/RefreshPolicyAMD64.exe" -OutFile "C:\Orbitel\Scripts\E8\WDAC\RefreshPolicyAMD64.exe" }"
SCHTASKS /CREATE /SC ONLOGON /TN "Orbitel\DeployWdac" /F /TR C:\Orbitel\Scripts\E8\WDAC\DeployWdac.ps1 /RU Users

pause