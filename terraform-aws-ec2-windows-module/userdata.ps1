<powershell>
# Rename Machine
Rename-Computer -NewName "pluto-server" -Force;

# Install IIS
Install-WindowsFeature -name Web-Server -IncludeManagementTools;
shutdown -r -t 10;

# # Replace the values in these variables with your own values
# $domainName = "42gears.com"
# $domainAdminUsername = "administrator"
# $domainAdminPassword = "42Gears@42"
# $ec2InstanceName = "ec2-instance"

# # Join the EC2 instance to the domain
# Add-Computer -DomainName $domainName -Credential (New-Object -TypeName System.Management.Automation.PSCredential -ArgumentList $domainAdminUsername, (ConvertTo-SecureString -String $domainAdminPassword -AsPlainText -Force)) -Restart

# # Set the hostname of the EC2 instance
# Rename-Computer -NewName $ec2InstanceName -Restart

# # Wait for the EC2 instance to restart and rejoin the domain
# Start-Sleep -Seconds 60

# # Check the domain membership of the EC2 instance
# $domain = [System.DirectoryServices.ActiveDirectory.Domain]::GetComputerDomain()
# Write-Output "EC2 instance is a member of the $($domain.Name) domain."

# # Stop the script from executing any further
# exit

# # Install the Web Server (IIS) role
# Install-WindowsFeature -Name Web-Server -IncludeManagementTools

# # Install the .NET Framework 3.5 feature
# Install-WindowsFeature -Name NET-Framework-Features -IncludeAllSubFeature -IncludeManagementTool

# # Install the Telnet Client feature
# Install-WindowsFeature -Name Telnet-Client
# # # Restart machine
# shutdown -r -t 10;
</powershell>