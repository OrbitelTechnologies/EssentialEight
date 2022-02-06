# Jerome Ryan - Orbitel Technologies - 21/12/2021
# This script was created to bring users in line with Essential Eight User Application Hardening Maturity Level 3.

#TODO:
#Web browser, Microsoft Office and PDF software security settings cannot be changed by users.
#ACSC or vendor hardening guidance for web browsers, Microsoft Office and PDF software is implemented.
#Maturity Level 1


#Maturity Level 3

# .NET Framework 3.5 (includes .NET 2.0 and 3.0) is disabled or removed.

cmd -c "DISM /Online /Disable-Feature /FeatureName:NetFx3"

#Windows PowerShell 2.0 is disabled or removed.
Disable-WindowsOptionalFeature -Online -FeatureName MicrosoftWindowsPowerShellV2Root

#PowerShell is configured to use Constrained Language Mode is dealt with by WDAC.
Set-RuleOption -FilePath "C:\Users\JeromeRyan\Downloads\Policy\Policy\SignedReputable012022.xml" -Option 11 

