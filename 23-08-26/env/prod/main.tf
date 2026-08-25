module "rg" {
  source = "../../module/rg"
  rg     = var.rg

}

module "vnet" {
  source = "../../module/vnet"
  vnet   = var.vnet

}

module "subnet" {
  source = "../../module/subnet"
  subnet = var.subnet

}

module "pip" {
  source = "../../module/public_ip"
  pip    = var.pip

}


module "nic" {
  depends_on = [module.rg, module.subnet]
  source     = "../../module/nic"
  nic        = var.nic
  subnet_ids = module.subnet.subnet_ids

}

module "vm" {
  depends_on = [module.nic]
  source     = "../../module/vm"

  vm = var.vm

  nic_ids = module.nic.nic_ids
}