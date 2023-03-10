variable "default_tags" {
  type = map(string)
}

variable "public_subnet_id" {
  type = string
}

variable "vpc_id" {
  type = string
}

variable "ssh_key_name" {
  type = string
}

variable "vpc_security_group_ids" {
  type = list
}