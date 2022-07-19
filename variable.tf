# VPC Requirement

variable "custom_vpc" {
  description = "VPC for DevOps Crash Course"
  type        = string
  default     = "10.0.0.0/16"
}


# EC2 Requirement

variable "instance_tenancy" {
  description = "it defines the tenancy of VPC. Whether it's default or dedicated"
  type        = string
  default     = "default"
}

variable "ami_id" {
  description = "ami id"
  type        = string
  default     = "ami-087c17d1fe0178315"
}

variable "instance_type" {
  description = "Instance type to create an instance"
  type        = string
  default     = "t2.micro"
}

variable "ssh_private_key" {
  description = "pem file of Keypair used to login to EC2 instances"
  type        = string
  default     = "./Keypair01.pem"
}