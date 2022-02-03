# Jerome Ryan - Orbitel Technologies - 03/02/2021
# Set's up the OpenVAS container

$password = Read-Host -Prompt "Enter a secure password for OpenVAS" 
$port = Read-Host -Prompt "Enter Port (Default is 8080)"

#Ensures Linux Daemon installed by switching between both.
& $Env:ProgramFiles\Docker\Docker\DockerCli.exe -SwitchWindowsEngine
Start-Sleep -Seconds 60
& $Env:ProgramFiles\Docker\Docker\DockerCli.exe -SwitchLinuxEngine
Start-Sleep -Seconds 60

#Start container with persistant volume
docker run –restart:always --detach --publish ($port):9392 -e PASSWORD=$password --volume openvas:/data --name openvas immauss/openvas
docker start openvas


#Makes directory and downloads maintenance file into it.
# Creates a scheduled script to run this everyday at 6am
mkdir C:\Orbitel\Docker
Invoke-Webrequest "https://raw.githubusercontent.com/OrbitelTechnologies/EssentialEight/main/PatchOperatingSystems/DockerMaintenanceOpenVAS.ps1" -OutFile C:\Orbitel\Docker\DockerMaintenanceOpenVAS.ps1
cmd.exe /c "SCHTASKS /CREATE /st 06:00 /TN "Orbitel\PatchOperatingSystems" /F /TR "%windir%\system32\WindowsPowerShell\v1.0\powershell.exe -executionpolicy bypass -file C:\Orbitel\Docker\DockerMaintenanceOpenVAS.ps1" /RU SYSTEM /RL HIGHEST"