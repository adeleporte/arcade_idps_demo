data "nsxt_policy_intrusion_service_profile" "default" {
  display_name = "DefaultIDSProfile"
}

resource "nsxt_policy_intrusion_service_profile" "web" {
  display_name = "WebProfile"
  description  = "Terraform provisioned Profile"
  severities   = ["HIGH", "CRITICAL", "MEDIUM", "LOW"]

  criteria {
    attack_targets      = ["Web_Server"]
  }
}

resource "nsxt_policy_intrusion_service_profile" "critical" {
  display_name = "CriticalProfile"
  description  = "Terraform provisioned Profile"
  severities   = ["CRITICAL"]

  criteria {
    cvss      = ["CRITICAL"]
  }
}

resource "nsxt_policy_intrusion_service_profile" "vdi" {
  display_name = "VdiProfile"
  description  = "Terraform provisioned Profile"
  severities   = ["HIGH", "CRITICAL", "MEDIUM"]

  criteria {
    products_affected      = ["Windows_XP_Vista_7_8_10_Server_32_64_Bit"]
  }
}