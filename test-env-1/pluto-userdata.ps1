<powershell>
# Rename Machine
Rename-Computer -NewName "pluto-server" -Force;

# Install .net 
Install-WindowsFeature .NET-Framework-45-Features;
 
# Install IIS
Install-WindowsFeature -name Web-Server -IncludeManagementTools;
shutdown -r -t 10;

</powershell>