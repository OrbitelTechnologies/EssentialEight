# Jerome Ryan - Orbitel Technologies - 03/02/2021
# Sets up the OpenVAS container


Write-Host "OpenVAS Container setup script. Created by Jerome Ryan for Orbitel Technologies"

# Self-elevate the script if required
if (-Not ([Security.Principal.WindowsPrincipal] [Security.Principal.WindowsIdentity]::GetCurrent()).IsInRole([Security.Principal.WindowsBuiltInRole] 'Administrator')) {
 if ([int](Get-CimInstance -Class Win32_OperatingSystem | Select-Object -ExpandProperty BuildNumber) -ge 6000) {
  $CommandLine = "-File `"" + $MyInvocation.MyCommand.Path + "`" " + $MyInvocation.UnboundArguments
  Start-Process -FilePath PowerShell.exe -Verb Runas -ArgumentList $CommandLine
  Exit
 }
}

$password = Read-Host -Prompt "Enter a secure password for OpenVAS" 
$port = Read-Host -Prompt "Enter Port (Default is 8080)"
$port = -join($port,":9392")

Write-Host "Setting to Windows Engine mode. Please wait..."
Write-Host "Setting to Linux Engine mode. Please wait..."
& $Env:ProgramFiles\Docker\Docker\DockerCli.exe -SwitchLinuxEngine
Start-Sleep -Seconds 60

Write-Host "Creating container..."
#Start container with persistant volume
docker run --detach --publish $port -e PASSWORD=$password --volume openvas:/data --name openvas immauss/openvas | Out-Null
Start-Sleep -Seconds 1
Write-Host "Starting Container..."
docker start openvas
Start-Sleep -Seconds 1
Write-Host "Setting container to start with operating system..."
docker update --restart unless-stopped openvas
Start-Sleep -Seconds 1


#Makes directory and downloads maintenance file into it.
# Creates a scheduled script to run this everyday at 6am
Write-Host "Creating C:\Orbitel\Docker directory..."
mkdir C:\Orbitel\Docker -ErrorAction SilentlyContinue
Start-Sleep -Seconds 1
Write-Host "Downloading maintenance script to C:\Orbitel\Docker..."
Invoke-Webrequest "https://raw.githubusercontent.com/OrbitelTechnologies/EssentialEight/main/PatchOperatingSystems/DockerMaintenanceOpenVAS.ps1" -OutFile C:\Orbitel\Docker\DockerMaintenanceOpenVAS.ps1
Start-Sleep -Seconds 1
Write-Host "Creating scheduled task to run daily at 6am..."
cmd.exe /c "SCHTASKS /CREATE /sc daily /st 06:00 /TN "Orbitel\DockerMaintenance" /F /TR "%windir%\system32\WindowsPowerShell\v1.0\powershell.exe -executionpolicy bypass -file C:\Orbitel\Docker\DockerMaintenanceOpenVAS.ps1" /RU SYSTEM /RL HIGHEST"


Read-Host -Prompt "Completed. Press any key to continue."