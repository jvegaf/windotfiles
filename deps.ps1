# Check to see if we are currently running "as Administrator"
if (!(Verify-Elevated)) {
   $newProcess = new-object System.Diagnostics.ProcessStartInfo "PowerShell";
   $newProcess.Arguments = $myInvocation.MyCommand.Definition;
   $newProcess.Verb = "runas";
   [System.Diagnostics.Process]::Start($newProcess);

   exit
}

### Update Help for Modules
Write-Host "Updating Help..." -ForegroundColor "Yellow"
Update-Help -Force

### Package Providers
Write-Host "Installing Package Providers..." -ForegroundColor "Yellow"
Get-PackageProvider NuGet -Force | Out-Null

### Chocolatey
Write-Host "Installing Desktop Utilities..." -ForegroundColor "Yellow"
if ((which cinst) -eq $null) {
    iex (new-object net.webclient).DownloadString('https://chocolatey.org/install.ps1')
    Refresh-Environment
    choco feature enable -n=allowGlobalConfirmation
}

### Windows Features
Write-Host "Installing Windows Features..." -ForegroundColor "Yellow"
Enable-WindowsOptionalFeature -Online -FeatureName containers -All -NoRestart | Out-Null

Refresh-Environment

### Node Packages
# Write-Host "Installing Node Packages..." -ForegroundColor "Yellow"
# if (which npm) {
#     npm update npm
#     npm install -g gulp
#     npm install -g node-inspector
#     npm install -g @angular/cli
#     npm install -g @angular/language-server
# }

