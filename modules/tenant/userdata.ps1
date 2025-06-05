<powershell>
# Set hostname
Rename-Computer -NewName "${env:COMPUTERNAME}-${env:TENANT}" -Force -Restart

# Sample connectivity check
Test-NetConnection -ComputerName ${db_endpoint} -Port 1433 | Out-File C:\db-check.txt

# Install IIS as an example
Install-WindowsFeature -Name Web-Server -IncludeManagementTools

# Create a simple HTML landing page
New-Item -Path "C:\inetpub\wwwroot\index.html" -ItemType "file" -Force -Value "<h1>Tenant ${env:TENANT} is live</h1>"
</powershell>