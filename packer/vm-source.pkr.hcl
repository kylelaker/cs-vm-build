
source "virtualbox-iso" "ubuntu-vm" {
  boot_command             = [
    "<esc><wait><esc><wait>",
    "/casper/vmlinuz",
    " auto url=http://{{ .HTTPIP }}:{{ .HTTPPort }}/oem-preseed.cfg",
    " automatic-ubiquity",
    " debug-ubiquity",
    " keymap=us",
    " boot=casper initrd=/casper/initrd.lz quiet noprompt splash --",
    "<enter>"
  ]
  boot_wait                = "5s"
  cpus                     = 2
  disk_size                = 20480
  export_opts              = [
    "--manifest",
    "--vsys", "0",
    "--description", "Build date: ${local.build_id}\nPacker version: ${packer.version}",
    "--product", "${var.vm_name} ${var.semester}",
    "--producturl", "https://linuxmint.com/",
    "--vendor", "JMU Unix Users Group",
    "--vendorurl", "${var.git_repo}",
    "--version", "${var.version}"
  ]
  format                   = "ova"
  guest_os_type            = "Ubuntu_64"
  hard_drive_discard       = true
  hard_drive_interface     = "sata"
  hard_drive_nonrotational = true
  headless                 = var.headless
  http_directory           = "http"
  iso_checksum             = "file:${var.mirror_url}/sha256sum.txt"
  iso_interface            = "sata"
  iso_url                  = "${var.mirror_url}/${var.iso_file}"
  memory                   = 4096
  output_directory         = local.output_dir
  output_filename          = "image-${lower(var.semester)}"
  sata_port_count          = 2
  shutdown_command         = "echo -e \"${var.ssh_pass}\\n\" | sudo -S poweroff"
  sound                    = var.audio
  ssh_password             = var.ssh_pass
  ssh_timeout              = "100m"
  ssh_username             = var.ssh_user
  vboxmanage               = [
    ["modifyvm", "{{.Name}}", "--audioin", "off"],
    ["modifyvm", "{{.Name}}", "--clipboard-mode", "bidirectional"],
    ["modifyvm", "{{.Name}}", "--graphicscontroller", "vmsvga"],
    ["modifyvm", "{{.Name}}", "--mouse", "usbtablet"],
    ["modifyvm", "{{.Name}}", "--pae", "on"], 
    ["modifyvm", "{{.Name}}", "--rtcuseutc", "on"],
    ["modifyvm", "{{.Name}}", "--usb", "on", "--usbehci", "off", "--usbxhci", "off"],
    ["modifyvm", "{{.Name}}", "--vram", "64"],
    ["modifyvm", "{{.Name}}", "--vrde", "off"],
    ["storagectl", "{{.Name}}", "--name", "IDE Controller", "--remove"],
    ["storagectl", "{{.Name}}", "--name", "SATA Controller", "--hostiocache", "on"]
  ]
  vboxmanage_post          = [
    ["modifyvm", "{{.Name}}", "--accelerate3d", "on"],
    ["storageattach", "{{.Name}}", "--storagectl", "SATA Controller", "--port", "1", "--type", "dvddrive", "--medium", "emptydrive"]
  ]
  vm_name                  = "${var.vm_name} ${var.semester}"
}
