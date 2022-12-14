<powershell>
# Rename Machine
Rename-Computer -NewName "${var.windows_instance_name}" -Force;

# Install IIS
Install-WindowsFeature -name Web-Server -IncludeManagementTools;

#adding machine to domain
# wmic computersystem where name="%computername%" call joindomainorworkgroup fjoinoptions=3 name="homelab.local" username="homelab\labadmin" Password="secret"
# Restart machine
shutdown -r -t 10;
</powershell>