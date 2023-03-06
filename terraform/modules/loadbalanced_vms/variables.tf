variable "number_of_vms" {
  type = number
}

variable "default_tags" {
  type = map(string)
}

variable "public_subnet_ids" {
  type = list(string)
}

variable "vpc_id" {
  type = string
}