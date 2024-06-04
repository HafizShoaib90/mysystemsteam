# Specify the provider and AWS region
provider "aws" {
  region = "us-east-1" # Replace with your desired region
 }

data "aws_vpc" "already" {
  id = "vpc-0ff4fedd8819099d8"
}


# Define the EC2 instance

resource "aws_instance" "windows_instance" {
  ami           = "ami-067de6f85aa9ad5f9" # Specify the Windows AMI ID
  instance_type = "t2.micro"              # Change instance type as needed
  key_name      = "testkp"            # Replace with your key pair name
  subnet_id     = "subnet-0299237b9f4ec6060"       # Replace with your subnet ID
  security_groups = ["sg-0f2f0debf121b4713"]  # Replace with your security group ID
 

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