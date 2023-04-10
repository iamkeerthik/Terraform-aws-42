<powershell>
Rename-Computer -NewName "db-server" -Force;
[Net.ServicePointManager]::SecurityProtocol = "tls12, tls11, tls";
$ProgressPreference = 'SilentlyContinue'

# Install the CloudWatch agent
Invoke-WebRequest -Uri "https://s3.amazonaws.com/amazoncloudwatch-agent/windows/amd64/latest/amazon-cloudwatch-agent.msi" -OutFile "C:\Windows\Temp\amazon-cloudwatch-agent.msi"
Start-Process -FilePath "msiexec.exe" -ArgumentList "/i C:\Windows\Temp\amazon-cloudwatch-agent.msi /quiet" -Wait

# Retrieve the CloudWatch agent configuration from AWS Systems Manager Parameter Store
$parameterName = "AmazonCloudWatch-windows"
Start-Service -Name "AmazonCloudWatchAgent"
& "C:\Program Files\Amazon\AmazonCloudWatchAgent\amazon-cloudwatch-agent-ctl.ps1" -a fetch-config -m ec2 -c ssm:$parameterName -s


$ssms_url = "https://aka.ms/ssmsfullsetup";
$output = "C:\SSMS-Setup-ENU.exe";
Invoke-WebRequest $ssms_url -OutFile $output;
Start-Process "C:\SSMS-Setup-ENU.exe" -ArgumentList "/install /quiet /norestart" -Wait;



 $sql_url = "https://go.microsoft.com/fwlink/?linkid=866658";
 $sql_output = "C:\sql_express.exe";
 Invoke-WebRequest $sql_url -OutFile $sql_output;
 Start-Process "C:\sql_express.exe" -ArgumentList "/QS /IACCEPTSQLSERVERLICENSETERMS /ACTION=install /FEATURES=SQL /INSTANCENAME=SQLEXPRESS /SQLSVCACCOUNT=`"NT Authority\System`" /SQLSYSADMINACCOUNTS=`"BUILTIN\Administrators`" /AGTSVCACCOUNT=`"NT Authority\Network Service`" /TCPENABLED=1 /NPENABLED=1 /SKIPRULES=`"PerfMonCounterNotCorruptedCheck,GlobalRules.Sql110NotSupportedRule`"" -Wait

 $mongo_url = "https://fastdl.mongodb.org/windows/mongodb-windows-x86_64-6.0.4-signed.msi"
 $mongo_output = "C:/mongodb.msi"
 Invoke-WebRequest $mongo_url -OutFile $mongo_output
 Start-Process "msiexec.exe" -ArgumentList "/i `"C:/mongodb.msi`" /qn" -Wait

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