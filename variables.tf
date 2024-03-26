variable "prefix" {
  description = "Prefix for resources created by this module no dash needed"
  default = "Test7"
  type        = string
}

variable "location" {
  type        = string
  default     = "westus2"
  description = "Azure Location of the deployment"
}
variable "resource_group_name" {
  description = "The name of the resource group in which the resources will be created"
  default="RG"
  type        = string
}
variable "vnet" {
  type = string
  default = "lab-vnet"
  description = "name of the VNET that contains networks for the BIG-IP"
}

variable "f5_username" {
  description = "The admin username of the F5 Bigip that will be deployed"
  type = string
  default     = "steve"
}

variable "f5_password" {
  description = "The admin password of the F5 Bigip that will be deployed"
  type = string
  default     = "P@ssw0rd!5"
}

variable "hostname1" {
  description = "Name of F5 BIGIP VM to be used,it should be unique `name`"
  default     = "f5-vm01"
}

variable "hostname2" {
  description = "Name of F5 BIGIP VM to be used,it should be unique `name`,default is empty string meaning module adds with prefix + random_id"
  default     = "f5-vm02"
}
variable "f5_product_name" {
  type        = string
  default     = "f5-big-ip-best"
}
variable "bigip_version" {
  type = string
  default = "17.1.101000"
}
variable "f5_image_name" {
  type        = string
  default     = "f5-big-best-plus-hourly-25mbps"
}
variable "mgmt_subnet" {
  type = string
  default = "one"
}
variable "internal_subnet" {
  type = string
  default = "two"
}
variable "internal_subnet_2" {
  type = string
  default = "three"
}
variable "external_subnet" {
  type = string
  default = "four"
}
variable "external_subnet_2" {
  type = string
  default = "five"
}

## BIGIP 1
variable "public_ip_bigip1" {
  default = "f51-public-ip-mgmt"
}
variable "default_gateway" {
  default = "10.9.2.1"
}
variable "mgmt_ip_bigip1" {
  type = string
  default = "10.9.1.11"  
}
variable "internal1_ip_bigip1" {
  type = string
  default = "10.9.2.11"
}
variable "internal2_ip_bigip1" {
  type = string
  default = "10.9.3.11"
}
variable "external1_ip_bigip1" {
  type = string
  default = "10.9.4.11"
}
variable "external2_ip_bigip1" {
  type = string
  default = "10.9.5.11"
}

#BIG IP 2
variable "public_ip_bigip2" {
  default = "f52-public-ip-mgmt"
}
variable "mgmt_ip_bigip2" {
  type = string
  default = "10.9.1.12"
}
variable "internal1_ip_bigip2" {
  type = string
  default = "10.9.2.12"
}
variable "internal2_ip_bigip2" {
  type = string
  default = "10.9.3.12"
}
variable "external1_ip_bigip2" {
  type = string
  default = "10.9.4.12"
}
variable "external2_ip_bigip2" {
  type = string
  default = "10.9.5.12"
}
variable "mgmt_nsg" {
  type = string
  default = "mgmt-nsg"
}
variable "internal_nsg" {
  type = string
  default = "internal-nsg"
}
variable "external_nsg" {
  type = string
  default = "external-nsg"
}

variable "f5_instance_type" {
  description = "Specifies the T-Shirt size of the virtual machine."
  type        = string
  default     = "Standard_Ds4_v2"
}

variable "image_publisher" {
  description = "Specifies product image publisher"
  type        = string
  default     = "f5-networks"
}

variable "f5_ssh_publickey" {
  description = "public key to be used for ssh access to the VM. e.g. c:/home/id_rsa.pub"
  default = "/ssh_key/pubkey"
}

variable "availability_zone_f51" {
  description = "If you want the VM placed in an Azure Availability Zone, and the Azure region you are deploying to supports it, specify the number of the existing Availability Zone you want to use."
  default     = 1
}
variable "availability_zone_f52" {
  description = "If you want the VM placed in an Azure Availability Zone, and the Azure region you are deploying to supports it, specify the number of the existing Availability Zone you want to use."
  default     = 2
}
variable "time_sleep" {
  type        = string
  default     = "300s"
  description = "The number of seconds/minutes of delay to build into creation of BIG-IP VMs; default is 250. BIG-IP requires a few minutes to complete the onboarding process and this value can be used to delay the processing of dependent Terraform resources."
}

variable "runtime_init" {
  default = "https://github.com/F5Networks/f5-bigip-runtime-init/releases/download/2.0.1/f5-bigip-runtime-init-2.0.1-1.gz.run"
  description = "Runtime init download"
}
variable "DO_URL" {
  description = "URL to download the BIG-IP Declarative Onboarding module"
  type        = string
  default     = "https://github.com/F5Networks/f5-declarative-onboarding/releases/download/v1.42.0/f5-declarative-onboarding-1.42.0-9.noarch.rpm"
}

variable "AS3_URL" {
  description = "URL to download the BIG-IP Application Service Extension 3 (AS3) module"
  type        = string
  default     = "https://github.com/F5Networks/f5-appsvcs-extension/releases/download/v3.49.0/f5-appsvcs-3.49.0-6.noarch.rpm"
}

variable "TS_URL" {
  description = "URL to download the BIG-IP Telemetry Streaming module"
  type        = string
  default     = "https://github.com/F5Networks/f5-telemetry-streaming/releases/download/v1.34.0/f5-telemetry-1.34.0-1.noarch.rpm"
}

variable "INIT_URL" {
  description = "URL to download the BIG-IP runtime init"
  type        = string
  default     = "https://cdn.f5.com/product/cloudsolutions/f5-bigip-runtime-init/v2.0.1/dist/f5-bigip-runtime-init-2.0.1-1.gz.run"
}