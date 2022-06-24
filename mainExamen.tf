terraform {
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 3.27"
    }
  }

  required_version = ">= 0.14.9"
}

provider "aws" {
  profile = "default"
  region  = "us-east-1"
}

resource "aws_launch_template" "EAE" {
  name = "LT-Examen_AdaaEsp"
  description = "Template for test"
  image_id = "ami-0022f774911c1d690"
  instance_type = "t2.micro"
  key_name = "Llave-Ada"

  vpc_security_group_ids = ["sg-04beabb75f4b4d46b"]
  user_data = "${filebase64("userdata.sh")}"
    tags = {
      Name = "Examen_AdaEsp"
    }
}

resource "aws_autoscaling_group" "bar" {
  name= "AG-Examen_AdaEsp"
  availability_zones = ["us-east-1a"]
  desired_capacity = 2
  max_size = 6
  min_size = 2 
  
  launch_template {
    id = aws_launch_template.EAE.id
    version = "$Latest"
  }

  tag {
    key = "Name"
    value = "Examen Ada Esp 2022"
    propagate_at_launch = true
  }
  

}