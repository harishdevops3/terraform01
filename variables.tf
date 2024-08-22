variable "vpc-name" {
  type        = string
  default     = "harish01-vpc"
  description = "name of vpc resource"
}

variable "vpc_cidr" {
  type        = string
  default     = "10.0.0.0/16"
  description = "cidr value for vpc"
}

variable "public_subnet_1a" {
  type        = string
  default     = "10.0.0.0/19"
  description = "public subnet cidr value for 1a zone"
}


variable "public_subnet_1b" {
  type        = string
  default     = "10.0.32.0/19"
  description = "public subnet cidr value for 1b zone"
}


variable "private_subnet_1a" {
  type        = string
  default     = "10.0.64.0/19"
  description = "private subnet cidr value for 1a zone"
}

variable "private_subnet_1b" {
  type        = string
  default     = "10.0.96.0/19"
  description = "private subnet cidr value for 1b zone"
}

