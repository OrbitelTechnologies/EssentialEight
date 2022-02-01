REM Created by Jerome Ryan 20/01/2022 for Orbitel Technologies

mkdir C:\Orbitel\Scripts\E8\WDAC

powershell -command "& { Invoke-Webrequest "https://github.com/OrbitelTechnologies/EssentialEight/raw/main/ApplicationControl/WDAC/Policy.zip" -OutFile "C:\Orbitel\Scripts\E8\WDAC\Policy.zip"} " 
powershell -command "& { Expand-Archive "C:\Orbitel\Scripts\E8\WDAC\Policy.zip" -DestinationPath "C:\Orbitel\Scripts\E8\WDAC\" -Force } " 
powershell -command "& { Invoke-Webrequest "https://github.com/OrbitelTechnologies/EssentialEight/raw/main/ApplicationControl/WDAC/DeployWdac.ps1" -OutFile "C:\Orbitel\Scripts\E8\WDAC\DeployWdac.ps1" } "
powershell -command "& { Invoke-Webrequest "https://github.com/OrbitelTechnologies/EssentialEight/raw/main/ApplicationControl/WDAC/RefreshPolicyAMD64.exe" -OutFile "C:\Orbitel\Scripts\E8\WDAC\RefreshPolicyAMD64.exe" } " 
SCHTASKS /CREATE /SC ONLOGON /TN "Orbitel\DeployWdac" /F /TR C:\Orbitel\Scripts\E8\WDAC\DeployWdac.ps1 /RU Users /RL HIGHEST
