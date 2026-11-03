# BEFORE: Over-provisioned unoptimized infrastructure
terraform {
  required_version = ">= 1.5.0"
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 5.40"
    }
  }
}

provider "aws" {
  region = "us-east-1"
}

# Expensive oversized instance for basic web service
resource "aws_instance" "oversized_web" {
  ami           = "ami-0c7217cdde317cfec"
  instance_type = "m5.4xlarge" # 16 vCPU, 64 GB RAM (~$560/month)

  root_block_device {
    volume_type = "io2"      # High IOPS expensive disk
    volume_size = 500
    iops        = 10000      # Heavy provisioning charges
  }
}

