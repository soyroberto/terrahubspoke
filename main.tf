#roberto@rober.to

terraform {
  cloud {

    organization = "soyroberto"

    workspaces {
      name = "Networks"
    }
  }
}
#---Variables
variable "subscription_id_a" {
  description = "Subscription ID A"
  type        = string
  sensitive   = true
}

variable "client_id_a" {
  description = "Client ID A"
  type        = string
  sensitive   = true
}

variable "client_secret_a" {
  description = "Client Secret A"
  type        = string
  sensitive   = true
}

variable "tenant_id_a" {
  description = "Tenant ID A"
  type        = string
  sensitive   = true
}

variable "subscription_id_b" {
  description = "Subscription ID B"
  type        = string
  sensitive   = true
}

variable "client_id_b" {
  description = "Client ID B"
  type        = string
  sensitive   = true
}

variable "client_secret_b" {
  description = "Client Secret B"
  type        = string
  sensitive   = true
}

variable "tenant_id_b" {
  description = "Tenant ID B"
  type        = string
  sensitive   = true
}




#---Variables values are stored in the Terraform cloud workspace no need to do env variables in the OS

# Provider for Subscription A Gomitos
provider "azurerm" {
  alias           = "sub_a"
  subscription_id = var.subscription_id_a
  client_id       = var.client_id_a
  client_secret   = var.client_secret_a
  tenant_id       = var.tenant_id_a

  features {}
}

# Provider for Subscription B - Chiclito
provider "azurerm" {
  alias           = "sub_b"
  subscription_id = var.subscription_id_b
  client_id       = var.client_id_b
  client_secret   = var.client_secret_b
  tenant_id       = var.tenant_id_b

  features {}
}

# Resource in Subscription A 
resource "azurerm_resource_group" "sub_a" {
  provider = azurerm.sub_a
  name     = "rgauehub_a"
  location = "Australia East"

  tags = {
    es           = "terraform"
    subscription = "gmts"
    region       = "aue"
    iac          = "terraform"

  }
}

# Resource in Subscription B
resource "azurerm_resource_group" "sub_b" {
  provider = azurerm.sub_b
  name     = "rgauehub_b"
  location = "Australia Southeast"

  tags = {
    es           = "terraform"
    subscription = "chclt"
    region       = "aus"
    iac          = "terraform"

  }
}

#--- Virtual Networks Definitions ---#

# Virtual Network in Subscription A
resource "azurerm_virtual_network" "vnet_a" {
  provider            = azurerm.sub_a
  name                = "vnet-a"
  location            = azurerm_resource_group.sub_a.location
  resource_group_name = azurerm_resource_group.sub_a.name
  address_space       = ["10.0.0.0/24"]

  subnet {
    name             = "AzureFirewallSubnet"
    address_prefixes = ["10.0.0.0/26"]
  }

  subnet {
    name             = "storage"
    address_prefixes = ["10.0.0.64/26"]
  }

  subnet {
    name             = "misc"
    address_prefixes = ["10.0.0.128/26"]
  }

  subnet {
    name             = "compute"
    address_prefixes = ["10.0.0.192/26"]
  }

  tags = {
    es           = "terraform"
    subscription = "gmts"
    region       = "aue"
    iac          = "terraform"
    cidr         = "/26"
    Network      = "vnet-a"
    peering      = "yes"
    networkrange = "10/26"
  }
}

# Virtual Network in Subscription B
resource "azurerm_virtual_network" "vnet_b" {
  provider            = azurerm.sub_b
  name                = "vnet-b"
  location            = azurerm_resource_group.sub_b.location
  resource_group_name = azurerm_resource_group.sub_b.name
  address_space       = ["172.16.0.0/24"]

  subnet {
    name             = "AzureFirewallSubnet"
    address_prefixes = ["172.16.0.0/26"]
  }

  subnet {
    name             = "storage"
    address_prefixes = ["172.16.0.64/26"]
  }

  subnet {
    name             = "misc"
    address_prefixes = ["172.16.0.128/26"]
  }

  subnet {
    name             = "compute"
    address_prefixes = ["172.16.0.192/26"]
  }

  tags = {
    es           = "terraform"
    subscription = "chclt"
    region       = "aus"
    iac          = "terraform"
    network      = "vnet-b"
    networkrange = "172/26"
  }
}