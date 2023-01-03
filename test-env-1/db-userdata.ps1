<powershell>
Rename-Computer -NewName "db-server" -Force;
[Net.ServicePointManager]::SecurityProtocol = "tls12, tls11, tls";
$ProgressPreference = 'SilentlyContinue'

$ssms_url = "https://aka.ms/ssmsfullsetup";
$output = "C:\SSMS-Setup-ENU.exe";
Invoke-WebRequest $ssms_url -OutFile $output;

# Start-Process -FilePath "C:\SSMS-Setup-ENU.exe" -ArgumentList '/install /quiet' -Wait;

 $sql_url = "https://go.microsoft.com/fwlink/?linkid=866658";
 $sql_output = "C:/sql_express.exe";
 Invoke-WebRequest $sql_url -OutFile $sql_output;

 $mongo_url = "https://fastdl.mongodb.org/tools/db/mongodb-database-tools-windows-x86_64-100.6.1.msi"
 $mongo_output = "C:/mongo_cli.msi"
 Invoke-WebRequest $mongo_url -OutFile $mongo_output

</powershell>