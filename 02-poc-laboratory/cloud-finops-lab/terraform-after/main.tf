# AFTER: Right-sized optimized infrastructure
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

# Right-sized compute instance matching observed telemetry load
resource "aws_instance" "optimized_web" {
  ami           = "ami-0c7217cdde317cfec"
  instance_type = "t3.medium" # 2 vCPU, 4 GB RAM (~$30/month)

  root_block_device {
    volume_type = "gp3"      # Modern General Purpose SSD
    volume_size = 50
    # Baseline 3,000 IOPS and 125 MB/s throughput included free with gp3
  }
}

