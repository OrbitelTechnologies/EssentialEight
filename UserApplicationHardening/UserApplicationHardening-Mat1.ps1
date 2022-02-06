# Jerome Ryan - Orbitel Technologies - 21/12/2021
# This script was created to bring users in line with Essential Eight User Application Hardening Maturity Level 1.

#TODO:
#Web browser, Microsoft Office and PDF software security settings cannot be changed by users.
#ACSC or vendor hardening guidance for web browsers, Microsoft Office and PDF software is implemented.
#Maturity Level 1

#Install U-Block Origin in Chrome
cmd -c "reg add "HKEY_LOCAL_MACHINE\SOFTWARE\Policies\Google\Chrome\ExtensionInstallForceList" /v "1" /t REG_SZ /d cjpalhdlnbpafiamejdnhcphjbkeiagm;https://clients2.google.com/service/update2/crx /f"

#Disables Java in Web browser.
(Get-Content C:\Users\$env:USERNAME\AppData\LocalLow\Sun\Java\Deployment\deployment.properties).replace('deployment.webjava.enabled=true', 'deployment.webjava.enabled=false') | Set-Content C:\Users\$env:USERNAME\AppData\LocalLow\Sun\Java\Deployment\deployment.properties

#Internet Explorer 11 is removed. This doesn't work on Windows 11 becuase it doesn't have IE.
Disable-WindowsOptionalFeature -online -FeatureName internet-explorer-optional-amd64

