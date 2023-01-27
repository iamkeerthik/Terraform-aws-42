<powershell>
# Rename Machine
Rename-Computer -NewName "pluto-server" -Force;
[Net.ServicePointManager]::SecurityProtocol = "tls12, tls11, tls";
$ProgressPreference = 'SilentlyContinue'

# Install .net 
Install-WindowsFeature .NET-Framework-45-Features;
 
# Install IIS
Install-WindowsFeature -name Web-Server -IncludeManagementTools;

 # download and install chrome
 Set-Location "C:\Windows\system32"

#Change TimeZone
C:\Windows\System32\tzutil /s "AUS Eastern Standard Time"

#Install Chrome 
$Path = $env:TEMP;
$Installer = "chrome_installer.exe";
Invoke-WebRequest "http://dl.google.com/chrome/install/375.126/chrome_installer.exe" -OutFile     $Path\$Installer; 
Start-Process -FilePath $Path\$Installer -ArgumentList "/silent /install" -Verb RunAs -Wait;
Remove-Item $Path\$Installer

#Set Chrome as default browser
$chromePath = "${Env:ProgramFiles(x86)}\Google\Chrome\Application\" 
$chromeApp = "chrome.exe"
$chromeCommandArgs = "--make-default-browser"
& "$chromePath$chromeApp" $chromeCommandArgs

##Download and install
Invoke-WebRequest https://github.com/notepad-plus-plus/notepad-plus-plus/releases/download/v8.4.8/npp.8.4.8.Installer.exe -OutFile C:\Windows\Temp\npp.8.4.8.Installer.exe

Start-Process C:\Windows\Temp\npp.8.4.8.Installer.exe /S -NoNewWindow -Wait -PassThru

shutdown -r -t 10;
</powershell>