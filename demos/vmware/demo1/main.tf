# VM build with CDRom ISO attached in ESXi

provider "vsphere" {
  user                 = "${var.vsphere_user}"
  password             = "${var.vsphere_password}"
  vsphere_server       = "${var.vsphere_server}"
  allow_unverified_ssl = true
}

data "vsphere_datacenter" "dc" {
  name = "Coresite"
}

data "vsphere_datastore" "datastore" {
  name          = "NFS_Store"
  datacenter_id = "${data.vsphere_datacenter.dc.id}"
}

data "vsphere_datastore" "iso_datastore" {
  name          = "ISOs"
  datacenter_id = "${data.vsphere_datacenter.dc.id}"
}

data "vsphere_compute_cluster" "cluster" {
  name          = "Test"
  datacenter_id = "${data.vsphere_datacenter.dc.id}"
}

data "vsphere_network" "network" {
  name          = "VM_Network"
  datacenter_id = "${data.vsphere_datacenter.dc.id}"
}

resource "vsphere_virtual_machine" "vm" {
  count						  = "1"
  name                        = "TFDemovm-0${count.index + 1}"
  resource_pool_id            = "${data.vsphere_compute_cluster.cluster.resource_pool_id}"
  datastore_id                = "${data.vsphere_datastore.datastore.id}"
  wait_for_guest_net_routable = false
  wait_for_guest_net_timeout  = 0

  num_cpus = 1
  memory   = 1024
  guest_id = "other3xLinux64Guest"

  cdrom {
    datastore_id = "${data.vsphere_datastore.iso_datastore.id}"
    path         = "ISO/Ubuntu/ubuntu-18.04-live-server-amd64.iso"
  }

  network_interface {
    network_id   = "${data.vsphere_network.network.id}"
    adapter_type = "vmxnet3"
  }

  disk {
    label            = "disk0"
    size             = 20
    thin_provisioned = true
  }
}
