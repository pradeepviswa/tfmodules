variable ami_id{
    type = string
    default = ""

}

variable instance_type{
    type = string
    default = ""
}

variable vm_name{
    type = string
    default = ""
}

variable key_name {
  description = "The name of the key."
  type        = string
}

variable "count_vm" {
  type = number
  default = 1
}

variable "allowed_ports" {
  type = list(number)
  default = [22, 8080, 3000]
}
