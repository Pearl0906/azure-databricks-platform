terraform {
  backend "azurerm" {
    use_azuread_auth = true

    tenant_id = "d0587cce-f58c-4438-97e7-aa7e3e6dc991"

    storage_account_name = "stazuredatabricksdev"
    container_name       = "tfstate"
    key                  = "dev.terraform.tfstate"
  }
}