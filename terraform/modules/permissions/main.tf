resource "databricks_permission_assignment" "workspace_user" {
  user_name   = var.user_name
  permissions = ["USER"]
}

resource "databricks_entitlements" "workspace_user" {
  user_id          = data.databricks_user.this.id
  workspace_access = true

  depends_on = [
    databricks_permission_assignment.workspace_user
  ]
}
