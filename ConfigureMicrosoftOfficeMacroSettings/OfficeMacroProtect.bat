REM  Files originating from the internet are blocked
reg add "HKEY_CURRENT_USER\Software\Microsoft\office\16.0\excel\security" /v "blockcontentexecutionfrominternet" /t REG_DWORD /d 1 /f
reg add "HKEY_CURRENT_USER\Software\Microsoft\office\16.0\powerpoint\security" /v "blockcontentexecutionfrominternet" /t REG_DWORD /d 1 /f
reg add "HKEY_CURRENT_USER\Software\Microsoft\office\16.0\visio\security" /v "blockcontentexecutionfrominternet" /t REG_DWORD /d 1 /f
reg add "HKEY_CURRENT_USER\Software\Microsoft\office\16.0\word\security" /v "blockcontentexecutionfrominternet" /t REG_DWORD /d 1 /f
reg add "HKEY_CURRENT_USER\software\policies\microsoft\office\16.0\access\security" /v "blockcontentexecutionfrominternet" /t REG_DWORD /d 1 /f


REM Microsoft Office macro antivirus scanning is enabled.
reg add "software\policies\microsoft\office\16.0\common\security" /v "macroruntimescanscope" /t REG_DWORD /d 2 /f
reg add "software\policies\microsoft\office\15.0\excel\security" /v "excelbypassencryptedmacroscan" /t REG_DWORD /d 0 /f


REM Need to implement" Microsoft Office macro security settings cannot be changed by users."

REM Microsoft Office macros are blocked from making Win32 API calls.
Set-MpPreference -AttackSurfaceReductionRules_Ids 92e97fa1-2edf-4476-bdd6-9dd0b4dddc7b -AttackSurfaceReductionRules_Actions Enabled

REM 