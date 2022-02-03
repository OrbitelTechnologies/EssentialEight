# Jerome Ryan - Orbitel Technologies - 03/02/2021
#Enables Containers as a windows feature, then downloads and installs Docker Desktop.

Install-WindowsFeature -Name 'Containers'

#Installs chocolatey
Set-ExecutionPolicy Bypass -Scope Process -Force; [System.Net.ServicePointManager]::SecurityProtocol = [System.Net.ServicePointManager]::SecurityProtocol -bor 3072; iex ((New-Object System.Net.WebClient).DownloadString('https://community.chocolatey.org/install.ps1'))

#Installs Docker Desktop
C:\ProgramData\chocolatey\choco.exe choco install docker-desktop


Read-Host -Prompt "Reboot required! Press any key to continue"

