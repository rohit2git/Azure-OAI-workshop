param serverName string = '<SQLSERVERNAME>'
param databaseName string = '<SQLDBNAME>'
param location string = '<AZURE_REGION>'
param adminLogin string = 'SqlAdmin'
param adminPswd string = 'ChangeYourAdminPassword1'


resource sqlServer 'Microsoft.Sql/servers@2021-02-01-preview' = {
  name: '${serverName}-${uniqueString(resourceGroup().id)}'
  location: location
  identity: {
    type: 'SystemAssigned'
  }
  properties: {
    administratorLogin: adminLogin
    administratorLoginPassword: adminPswd
  }
}

resource sqlServerFirewallRules 'Microsoft.Sql/servers/firewallRules@2020-11-01-preview' = {
  parent: sqlServer
  name: 'Allow Azure Services - ${serverName}-${uniqueString(resourceGroup().id)}'
  properties: {
    startIpAddress: '0.0.0.0'
    endIpAddress: '255.255.255.255'
  }
}

resource sqlDatabase 'Microsoft.Sql/servers/databases@2021-02-01-preview' = {
  name: '${databaseName}-${uniqueString(resourceGroup().id)}'
  parent: sqlServer
  location: location
  properties: {
    collation: 'SQL_Latin1_General_CP1_CI_AS'
    sampleName: 'AdventureWorksLT'
  }
}
