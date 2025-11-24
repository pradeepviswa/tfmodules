variable "instances" {
  type = map(object({
    ami_id        = string
    instance_type = string
    vm_name       = string
    key_name      = optional(string, "key_l")
  }))
}