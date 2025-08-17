# This script will run instance & security Group inbound rules & ourbound rules 
resource "aws_instance" "jenkins" {
  ami           = "ami-09c813fb71547fc4f"
  instance_type = "t3.small" # Instance type, can be changed as needed
  vpc_security_group_ids = [aws_security_group.allow_all_jenkins.id] # Security Group ID

  # user_data = file("jenkins.sh") # User data script to install jenkins
  # tags = { # Tags for the instance
  #   Name = "jenkins" # Name of the instance
  # }
}
resource "aws_security_group" "allow_all_jenkins" {
    name        = "allow_all_jenkins"
    description = "allow all traffic"

    ingress {
        from_port        = 0
        to_port          = 0
        protocol         = "-1"
        cidr_blocks      = ["0.0.0.0/0"]
        ipv6_cidr_blocks = ["::/0"]
    }
    egress {
        from_port        = 0
        to_port          = 0
        protocol         = "-1"
        cidr_blocks      = ["0.0.0.0/0"]
        ipv6_cidr_blocks = ["::/0"]
    }

    tags = {
        Name = "allow-all-jenkins"
    }
}