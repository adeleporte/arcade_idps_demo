resource "nsxt_policy_group" "nsg_prod" {
  display_name = "prod"
  description  = "Arcade Prod Group"
  criteria {
    condition {
      key         = "Tag"
      member_type = "VirtualMachine"
      operator    = "EQUALS"
      value       = "env|prod"
    }
  }
}

resource "nsxt_policy_group" "nsg_dev" {
  display_name = "dev"
  description  = "Arcade Dev Group"
  criteria {
    condition {
      key         = "Tag"
      member_type = "VirtualMachine"
      operator    = "EQUALS"
      value       = "env|dev"
    }
  }
}

resource "nsxt_policy_group" "nsg_web" {
  display_name = "web"
  description  = "Arcade Web Group"
  criteria {
    condition {
      key         = "Tag"
      member_type = "VirtualMachine"
      operator    = "EQUALS"
      value       = "tier|web"
    }
  }
}

resource "nsxt_policy_group" "nsg_vdi" {
  display_name = "vdi"
  description  = "Arcade Vdi Group"
  criteria {
    condition {
      key         = "Tag"
      member_type = "VirtualMachine"
      operator    = "EQUALS"
      value       = "tier|vdi"
    }
  }
}

resource "nsxt_policy_group" "nsg_critical" {
  display_name = "critical"
  description  = "Arcade Critical Group"
  criteria {
    condition {
      key         = "Tag"
      member_type = "VirtualMachine"
      operator    = "EQUALS"
      value       = "criticity|high"
    }
  }
}