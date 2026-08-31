module "rg" {
  source = "../../module/rg"
  rg     = var.rg
}



module "vnet" {
  depends_on = [module.rg]

  source = "../../module/vnet"
  vnet   = var.vnet
}

module "nsg" {
  depends_on = [module.rg]

  source = "../../module/nsg"
  nsg    = var.nsg
}

module "subnet" {
  depends_on = [module.rg, module.nsg, module.vnet]

  source  = "../../module/subnet"
  subnet  = var.subnet
  nsg_ids = module.nsg.nsg_ids
}

module "pip" {
  depends_on = [module.rg]

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

  source  = "../../module/vm"
  vm      = var.vm
  nic_ids = module.nic.nic_ids
}
