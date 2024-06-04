# Specify the provider and AWS region
provider "aws" {
  region = "us-east-1" # Replace with your desired region
 }


# Define the EC2 instance

resource "aws_instance" "windows_instance" {
  ami           = "ami-0c24dc9d92f3c28ea" # Specify the Windows AMI ID
  instance_type = "t2.micro"              # Change instance type as needed
  key_name      = "my-keypair"            # Replace with your key pair name
  subnet_id     = "subnet-0b8aa00f4cffb226c"       # Replace with your subnet ID
  security_groups = ["sgr-067bc0e8f419439e9"]  # Replace with your security group ID
  

tags = {
    Name = "AWS-test-SVR"
}

 user_data = <<-EOF
    <powershell>
    # Configure the instance (e.g., install software, configure settings)

    # Set the new computer name
    
    $NewComputerName = "MYServer1"
    (Get-WmiObject -Class Win32_ComputerSystem).Rename($NewComputerName)
   

# Set DNS server addresses
    $DnsServers = "10.0.0.37"  # Replace with your desired DNS server IP addresses
    
    # Configure DNS servers
    $NetworkInterface = Get-NetAdapter | Where-Object { $_.Status -eq "Up" }
    $NetworkInterface | Set-DnsClientServerAddress -ServerAddresses $DnsServers



    # Restart the instance to apply DNS changes
    Restart-Computer -Force
</powershell>
EOF
}


# Output the public IP address of the instance

  output "public_ip" {
  value = aws_instance.windows_instance.public_ip
  }