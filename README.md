"# tfmodules" 
module "key_file" {
  source   = "git::https://github.com/pradeepviswa/tfmodules.git//key_file?ref=main"
  key_name = "var.key_name"
}

