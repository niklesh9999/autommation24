output "nic_ids" {
  value = {
    for key, network_interface in azurerm_network_interface.nic :
    key => network_interface.id

  }
}