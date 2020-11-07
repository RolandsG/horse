variable "availability_zone" {
  default = "eu-central-1a"
}

variable "my_ip_address" {
  type = list(string)
  default = ["92.63.86.131/32"] 
}

variable "vpc_cidr_block" {
  default = "10.4.0.0/16"
}

variable "subnet_public_cidr_block" {
  default = "10.4.0.0/24"
}

variable "public_subnet_type" {
  default = "public"
}

variable "route_table_public_cidr_block" {
  default = "0.0.0.0/0"
}

variable "route_table_public_name" {
  default = "rt-public"
}
