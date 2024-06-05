provider "aws" {
  region = "us-west-1" 
 }


resource "aws_instance" "windows_instance" {
  ami           = "ami-0e6552a39ee0995d6" 
  instance_type = "t2.micro"              
  key_name      = "testkp"            
  subnet_id     = "subnet-0299237b9f4ec6060"       
  security_groups = ["sg-0864ecb531cc484cf"]  
 

tags = {
    Name = "AWS-test-SVR"
}

 user_data = <<-EOF
    <powershell>
    # Configure the instance (e.g., install software, configure settings)

    # Set the new computer name
    
    $NewComputerName = "MYServer1"
    (Get-WmiObject -Class Win32_ComputerSystem).Rename($NewComputerName)
   
   #install IIS
   Install-WindowsFeature -Name Web-Server -IncludeManagementTools


# Set DNS server addresses
    $DnsServers = "172.31.0.24"  # Replace with your desired DNS server IP addresses
    
    # Configure DNS servers
    $NetworkInterface = Get-NetAdapter | Where-Object { $_.Status -eq "Up" }
    $NetworkInterface | Set-DnsClientServerAddress -ServerAddresses $DnsServers

    # Restart the instance to apply DNS changes
     Restart-Computer -Force

</powershell>
EOF
}