variable "vpc_cidr" {
  type        = string
  default     = "10.0.0.0/16"
  description = "vpc cidr value"
}

variable "public_subnet_cidr" {
  type        = list(string)
  default     = ["10.0.0.0/19", "10.0.32.0/19"]
  description = "public subnet cidr value"
}

variable "private_subnet_cidr" {
  type        = list(string)
  default     = ["10.0.64.0/19", "10.0.96.0/19"]
  description = "private subnet cidr value"
}

variable "database_subnet_cidr" {
  type        = list(string)
  default     = ["10.0.128.0/19", "10.0.160.0/19"]
  description = "database subnet cidr value"
}

variable "instance_type" {
  type        = string
  default     = "t2.micro"
  description = "instance type"
}


variable "no_of_instance" {
  type        = number
  default     = 1
  description = "number of instance create"
}

variable "ingress_ports" {
  type        = list(number)
  default     = [80, 22, 443, 8080]
  description = "ingress ports"
}






