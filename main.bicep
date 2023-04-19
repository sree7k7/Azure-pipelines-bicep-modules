@description('Location for all resources.')
param location string = resourceGroup().location

module virtualnetowk './modules/vnet_vpngw.bicep' = {
  name: 'vnet'
  params: {
    location: location
    virtualNetworkName: 'Vnet'
    VnetIpPrefix: '10.3.0.0/16'
    FrontEndIpPrefix: '10.3.2.0/24'
    GatewaySubnetIpPrefix: '10.3.3.0/24'
    bastionSubnetIpPrefix: '10.3.4.0/27'
  }
}

module vm './modules/vm.bicep' = {
  name: 'vm'
  params: {
    location: location
    virtualNetworkName: virtualnetowk.name
    subnetRef: virtualnetowk.outputs.frontendsubnetname
    vmSize: 'Standard_D2s_v3'
    numberOfInstances: 1
    vmNamePrefix: virtualnetowk.name
  }
}
