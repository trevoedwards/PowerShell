# Script purpose: Collect Hardware Hash, rename file to machine name, then upload to network share

# Write-Host $Machine
$Machine = (Get-CimInstance -ClassName Win32_ComputerSystem).Name

If ( !(Test-Path -Path "c:\HWID")) {
    New-Item -Type Directory -Path "C:\HWID"
}
Set-Location -Path "C:\HWID"
$env:Path += ";C:\Program Files\WindowsPowerShell\Scripts"
Set-ExecutionPolicy -ExecutionPolicy Undefined -Scope localMachine
Install-Script -Name Get-WindowsAutopilotInfo
Get-WindowsAutopilotInfo  -OutputFile "$machine.csv"  
#Copy the created Hash File to \\SANITIZED\NETWORK\LOCATION\
New-PSDrive -Name "J" -PSProvider "FileSystem" -Root "\\SANITIZED\NETWORK\LOCATION\"
Copy-Item  "C:\HWID\*.csv" -Destination "J:\" -Force
Remove-PSDrive -Name J
$LASTEXITCODE
