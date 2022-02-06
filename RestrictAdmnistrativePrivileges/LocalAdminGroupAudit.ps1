<#
.Synopsis
   Script to check membership of the local administrators group on client computers.
.DESCRIPTION
   Script to check membership of the local administrators group on client computers.
   Robert Pearman / WindowsServerEssentials.com
   Version 1.0 August 2018
   Requires use of remote WMI queries to client computers and the ActiveDirectory PowerShell Module.

.EXAMPLE

    LocalAdminGroupAudit.ps1 -ou "ou=myOU,ou=myCompany,dc=myDomain,dc=com" -excludeNames "Administrator","Domain Admins" -activeDays 30

    Search for computers active in the last 30 days in the myOU OU and for members of local administrators group excluding Administrator and the Domain Admins group.

.EXAMPLE

    LocalAdminGroupAudit.ps1 -pcName PC01 -excludeNames "Administrator","Domain Admins"

    Query PC01 for members of local administrators group excluding Administrator and the Domain Admins group.
#>

param(
[array]$excludeNames,
[Parameter(ParameterSetName="Domain")]
[string]$ou,
[int]$activeDays,
[Parameter(ParameterSetName="Computer")]
[string]$pcName
)
$padVal = 22
$adminLabel = "Admin Users".PadRight($padVal," ")
$badLabel = "Total invalid Accounts".PadRight($padVal," ")
$onlineLabel = "Online Computers".PadRight($padVal," ")
$offlineLabel = "Offline Computers".PadRight($padVal," ")
$activeLabel = "Computers Active Since".PadRight($padVal," ")
Write-Output "Local Admin Group membership audit tool. Searches computers for membership of Local Administrators group."
Write-Output "Accounts not listed in -excludeNames will be displayed."
if($ou)
{
    $searchLabel = "Searching Computers in".PadRight($padVal," ")
    Write-Output "$searchLabel : $ou"
    $now  = [datetime]::Now
    $searchDays = $now.AddDays(-$activedays)
    Write-Output "$activeLabel : $searchDays"
}
if($pcName)
{
    $searchLabel = "Searching Computer".PadRight($padVal," ")
    Write-Output "$searchLabel : $pcName"
}
Write-Output "$adminLabel : $excludeNames"
$compFoundLabel = "Computers Found".PadRight($padVal, " ")
$badAccounts = 0
$onlineComputer = 0
$offlineComputer = 0
if($ou)
{
    $computers = Get-AdComputer -filter {LastLogonDate -ge $searchDays } -searchbase $ou -properties LastLogonDate | sort Name -Descending
}
if($pcName)
{
    $computers = Get-AdComputer $pcName -properties *
}
$computerCount = ($computers | Measure-Object).Count
$pCounter = 0
Write-Output "$compFoundLabel : $computerCount"
foreach ($computer in $computers )
{
    $pCounter++
    Write-Progress -Activity "Searching.. Please Wait.." -Status $computer.Name -PercentComplete ($pCounter / $computerCount*100)
    try{
        $groupMembers = get-wmiobject win32_groupUser -ComputerName $computer.Name -ErrorAction Stop
        $onlineComputer++
        $groupMembers = $groupMembers | where { $_.GroupComponent -like "*Administrators*"}
        foreach ($member in $groupMembers)
        {
            $name = $member.PartComponent.Split("=")
            $uName = $name[2].Replace('"',"")
            $gName = $member.GroupComponent.Split("=")
            $gName = $gName[2].Replace('"',"")
            if(($excludeNames) -contains $uName)
            {
                # Skip
            }
            else
            {
                $badAccounts++
                $comGroupObj = New-Object System.Object
                $comGroupObj | Add-Member -MemberType NoteProperty -Name Name -Value $computer.Name
                $comGroupObj | Add-Member -MemberType NoteProperty -Name UserName -Value $uName
                $comGroupObj | Add-Member -MemberType NoteProperty -Name GroupName -Value $gName
                $comGroupObj
            }
        }
    }
    catch{
        $offlineComputer++
    }
}
Write-Output ""
Write-Output "$badLabel : $badAccounts"
Write-Output "$onlineLabel : $onlineComputer"
Write-Output "$offlineLabel : $offlineComputer"