terraform {
  required_providers {
    nsxt = {
      source = "vmware/nsxt"
    }
  }
}

provider "nsxt" {
  host                  = var.nsx_manager
  username              = var.nsx_username
  password              = var.nsx_password
  allow_unverified_ssl  = true
  max_retries           = 10
  retry_min_delay       = 500
  retry_max_delay       = 5000
  retry_on_status_codes = [429]
}

variable "nsx_manager" {
  description = "NSX Manager IP / FQDN"
  type        = string
}

variable "nsx_username" {
  description = "NSX administrator username"
  type        = string
  sensitive   = true
}
variable "nsx_password" {
  description = "NSX administrator password"
  type        = string
  sensitive   = true
}


resource "nsxt_policy_intrusion_service_policy" "prod-ids-policy" {
  display_name = "Prod"
  description  = "Arcade production ids policy"
  locked       = false
  stateful     = true

  rule {
    display_name       = "Web"
    destination_groups = [nsxt_policy_group.nsg_web.path]
    scope              = [nsxt_policy_group.nsg_prod.path]
    action             = "DETECT_PREVENT"
    logged             = true
    ids_profiles       = [nsxt_policy_intrusion_service_profile.web.path]
  }

  rule {
    display_name       = "Vdi"
    destination_groups = [nsxt_policy_group.nsg_vdi.path]
    scope              = [nsxt_policy_group.nsg_prod.path]
    action             = "DETECT_PREVENT"
    logged             = true
    ids_profiles       = [nsxt_policy_intrusion_service_profile.vdi.path]
  }

  rule {
    display_name       = "Critical"
    destination_groups = [nsxt_policy_group.nsg_critical.path]
    scope              = [nsxt_policy_group.nsg_prod.path]
    action             = "DETECT_PREVENT"
    logged             = true
    ids_profiles       = [nsxt_policy_intrusion_service_profile.critical.path]
  }
  
}

resource "nsxt_policy_intrusion_service_policy" "dev-ids-policy" {
  display_name = "Dev"
  description  = "Arcade production ids policy"
  locked       = false
  stateful     = true

  rule {
    display_name       = "Web"
    destination_groups = [nsxt_policy_group.nsg_web.path]
    scope              = [nsxt_policy_group.nsg_dev.path]
    action             = "DETECT"
    logged             = true
    ids_profiles       = [nsxt_policy_intrusion_service_profile.web.path]
  }

  rule {
    display_name       = "Vdi"
    destination_groups = [nsxt_policy_group.nsg_vdi.path]
    scope              = [nsxt_policy_group.nsg_dev.path]
    action             = "DETECT"
    logged             = true
    ids_profiles       = [nsxt_policy_intrusion_service_profile.vdi.path]
  }

  rule {
    display_name       = "Critical"
    destination_groups = [nsxt_policy_group.nsg_critical.path]
    scope              = [nsxt_policy_group.nsg_dev.path]
    action             = "DETECT"
    logged             = true
    ids_profiles       = [nsxt_policy_intrusion_service_profile.critical.path]
  }
  
}