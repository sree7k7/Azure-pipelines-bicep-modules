@description('Location for all resources.')
param location string = resourceGroup().location

param company string = 'contoso'
param env string = 'dev'

module virtualnetowk './modules/vnet_vpngw.bicep' = {
  name: 'vnet'
  params: {
    location: location
    virtualNetworkName: 'Vnet'
    VnetIpPrefix: '10.3.0.0/16'
    FrontEndIpPrefix: '10.3.2.0/24'
    GatewaySubnetIpPrefix: '10.3.3.0/24'
    bastionSubnetIpPrefix: '10.3.4.0/27'
    psk: 'abc@143'
    cgwip: '23.4.67.23'
    bgp_peer_ip: '2.3.4.5'
  }
}

module vmachine './modules/vm.bicep' = {
  name: 'vm2'
  params: {
    Servername: 'frontend'
    location: location
    virtualNetworkName: virtualnetowk.name
    subnetRef: virtualnetowk.outputs.frontendsubnetname
    vmSize: 'Standard_D2s_v3'
    numberOfInstances: 0
    vmNamePrefix: virtualnetowk.name
    Project: company
    Environment: env
  }
}

// module vmachin './modules/vm.bicep' = {
//   name: 'vm'
//   params: {
//     Servername: 'vmserver2'
//     location: location
//     virtualNetworkName: virtualnetowk.name
//     subnetRef: virtualnetowk.outputs.frontendsubnetname
//     vmSize: 'Standard_D2s_v3'
//     numberOfInstances: 1
//     vmNamePrefix: virtualnetowk.name
//   }
// }
