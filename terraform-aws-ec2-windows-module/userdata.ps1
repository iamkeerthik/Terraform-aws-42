<powershell>
# Rename Machine
Rename-Computer -NewName "${var.windows_instance_name}" -Force;

# Install IIS
Install-WindowsFeature -name Web-Server -IncludeManagementTools;

# Restart machine
shutdown -r -t 10;
</powershell>