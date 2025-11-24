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

variable "key_name_vm" {
  type = string
  default = "key_l"
}

variable "count_vm" {
  type = number
  default = 1
}