variable "git_branch" {
  type    = string
  default = "main"
}

variable "git_repo" {
  type    = string
  default = "https://github.com/jmunixusers/cs-vm-build"
}

variable "headless" {
  type    = bool
  default = true
}

variable "semester" {
  type    = string
  default = "Fa20"
}

variable "ssh_pass" {
  type    = string
  default = "oem"
}

variable "ssh_user" {
  type    = string
  default = "oem"
}

variable "version" {
  type    = string
}

variable "vm_name" {
  type    = string
}

variable "iso_file" {
  type    = string
}

variable "mirror_url" {
  type    = string
}

variable "audio" {
  type    = string
}

locals {
  timestamp = regex_replace(timestamp(), "[- TZ:]", "")
  output_dir = "${path.cwd}/artifacts_mint"
  build_id = "${local.timestamp}"
}
