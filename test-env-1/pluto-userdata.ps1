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

# Install the CloudWatch agent
Invoke-WebRequest -Uri "https://s3.amazonaws.com/amazoncloudwatch-agent/windows/amd64/latest/amazon-cloudwatch-agent.msi" -OutFile "C:\Windows\Temp\amazon-cloudwatch-agent.msi"
Start-Process -FilePath "msiexec.exe" -ArgumentList "/i C:\Windows\Temp\amazon-cloudwatch-agent.msi /quiet" -Wait

# Retrieve the CloudWatch agent configuration from AWS Systems Manager Parameter Store
$parameterName = "AmazonCloudWatch-windows"
Start-Service -Name "AmazonCloudWatchAgent"
& "C:\Program Files\Amazon\AmazonCloudWatchAgent\amazon-cloudwatch-agent-ctl.ps1" -a fetch-config -m ec2 -c ssm:$parameterName -s

# Download the AWS CLI installer
Invoke-WebRequest -Uri "https://awscli.amazonaws.com/AWSCLIV2.msi" -OutFile "$env:TEMP\AWSCLIV2.msi"

# Install the AWS CLI
Start-Process msiexec -ArgumentList "/i $env:TEMP\AWSCLIV2.msi /quiet" -Wait

# Set the version of kubectl to install
$kubectl_version = "v1.26.0"

# Download the kubectl binary
Invoke-WebRequest -Uri "https://dl.k8s.io/release/$($kubectl_version)/bin/windows/amd64/kubectl.exe" -OutFile "$env:ProgramFiles\kubectl.exe"

# Add the kubectl binary to the PATH
$env:Path += ";$env:ProgramFiles"

# Test the installation
kubectl version --client

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