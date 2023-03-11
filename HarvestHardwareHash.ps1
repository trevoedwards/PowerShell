# Script purpose: Collect Hardware Hash, rename file to machine name, then upload to network share

$Machine = (Get-CimInstance -ClassName Win32_ComputerSystem).Name
#$Machine = (Get-WmiObject -class win32_bios).SerialNumber  
If ( !(Test-Path -Path "c:\HWID")) {
    New-Item -Type Directory -Path "C:\HWID"
    }

Set-Location -Path "C:\HWID"
$env:Path += ";C:\Program Files\WindowsPowerShell\Scripts"
Set-ExecutionPolicy -ExecutionPolicy Undefined -Scope localMachine
Install-Script -Name Get-WindowsAutopilotInfo
Get-WindowsAutopilotInfo  -OutputFile "$machine.csv"
 
$PSEmailserver=“smtp.serverhere.com"
$From=sanitized@work.com”
$Email="sanitized@work.com"
$Subject=”Intune/AP HWID Atttached”
$Body=”Hardware Id (HWID) file for Machine $Machine is attached. Upload this file to Intune/Autopilot.
 https://endpoint.microsoft.com/#view/Microsoft_Intune_Enrollment/AutoPilotDevicesBlade/filterOnManualRemediationRequired~/false”
$attachment = "C:\HWID\$machine.csv"
SEND-MAILMESSAGE -to $Email –from $from –subject $subject -attachment $attachment  –body $body –smtpserver $psemailserver
Set-Location -Path "C:\"
$LASTEXITCODE
