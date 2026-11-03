variable "vpc_name" {
  type        = string
  description = "Name tag for the VPC."
}

variable "cidr_block" {
  type        = string
  description = "CIDR block for the VPC."
  default     = "10.0.0.0/16"
}

variable "public_subnets" {
  type        = list(string)
  description = "List of public subnet CIDRs."
  default     = ["10.0.1.0/24", "10.0.2.0/24"]
}

variable "availability_zones" {
  type        = list(string)
  description = "Target availability zones."
  default     = ["us-east-1a", "us-east-1b"]
}

variable "tags" {
  type        = map(string)
  default     = {}
}

