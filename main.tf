# Specify the provider and region
provider "aws" {
  region = "eu-north-1"
}

# Define the security group to allow specific ports
resource "aws_security_group" "depi_sg" {
  name        = "depi_sg"
  description = "Allow inbound traffic on ports 22, 443, 80, and 8080"

  ingress {
    from_port   = 22
    to_port     = 22
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  ingress {
    from_port   = 80
    to_port     = 80
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  ingress {
    from_port   = 443
    to_port     = 443
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  ingress {
    from_port   = 8080
    to_port     = 8080
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  # Allow all outbound traffic
  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }
}

# Define the EC2 instance
resource "aws_instance" "depi_project" {
  ami           = "ami-08eb150f611ca277f"   
  instance_type = "t3.micro"
  key_name      = "EN1Key"           

  # Attach the security group
  security_groups = [aws_security_group.depi_sg.name]

  # Tag the instance with a name
  tags = {
    Name = "depi-project"
  }
}