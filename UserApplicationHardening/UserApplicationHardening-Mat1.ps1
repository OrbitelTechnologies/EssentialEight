# Jerome Ryan - Orbitel Technologies - 21/12/2021
# This script was created to bring users in line with Essential Eight User Application Hardening Maturity Level 1.

#Installs chocolatey
Set-ExecutionPolicy Bypass -Scope Process -Force; [System.Net.ServicePointManager]::SecurityProtocol = [System.Net.ServicePointManager]::SecurityProtocol -bor 3072; iex ((New-Object System.Net.WebClient).DownloadString('https://community.chocolatey.org/install.ps1'))

#Installs Adblocker for Chrome and Firefox
C:\ProgramData\chocolatey\choco.exe install ublockorigin-chrome -y
C:\ProgramData\chocolatey\choco.exe install adblockplus-firefox -y

#Disables Java in Web browser.
(Get-Content C:\Users\$env:USERNAME\AppData\LocalLow\Sun\Java\Deployment\deployment.properties).replace('deployment.webjava.enabled=true', 'deployment.webjava.enabled=false') | Set-Content C:\Users\$env:USERNAME\AppData\LocalLow\Sun\Java\Deployment\deployment.properties

#Uninstalls Internet Explorer 11. This doesn't work on Windows 11 becuase it doesn't have IE.
Disable-WindowsOptionalFeature -online -FeatureName internet-explorer-optional-amd64