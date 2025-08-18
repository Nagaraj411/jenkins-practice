# This script will run instance & security Group inbound rules & ourbound rules 
resource "aws_instance" "jenkins" {
  ami           = "ami-09c813fb71547fc4f"
  instance_type = "t3.micro" # Instance type, can be changed as needed
  vpc_security_group_ids = [aws_security_group.allow_all_jenkins.id] # Security Group ID

    user_data = file("jenkins.sh") # User data script to install jenkins
   tags = { # Tags for the instance
    Name = "jenkins" # Name of the instance
   }
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

# # Creating route 53 Record for jenkins
# resource "aws_route53_record" "jenkins" {
#   zone_id         = "Z05005862BAG0R5BQ5WUP" # Replace with your Route 53 hosted zone ID
#   name            = "jenkins" #jenkins-dev.devops84.shop
#   type            = "A"
#   ttl             = 1
#   records         = [aws_instance.jenkins.public_ip]
#   allow_overwrite = true
# }
