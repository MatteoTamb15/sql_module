resource "google_sql_database_instance" "main" {
  name                = var.name
  project             = var.project
  database_version    = var.database_version
  region              = var.region
  deletion_protection = var.deletion_protection

  settings {
    tier              = var.tier
    availability_type = var.availability_type

    disk_autoresize = var.disk_autoresize
    disk_size       = var.disk_size
    disk_type       = var.disk_type

    dynamic "ip_configuration" {
      for_each = try(length(var.authorized_networks), 0) > 0 ? [var.authorized_networks] : []
      content {
        ipv4_enabled = true
        dynamic "authorized_networks" {
          for_each = var.authorized_networks
          content {
            name  = authorized_networks.value.name
            value = authorized_networks.value.value
          }
        }
      }
    }

    dynamic "backup_configuration" {
      for_each = var.backup_configuration_enabled == null ? [] : [var.backup_configuration_enabled]
      content {
        enabled                        = true
        binary_log_enabled             = var.backup_configuration_binary_log_enabled
        point_in_time_recovery_enabled = var.backup_configuration_point_in_time_recovery_enabled
        start_time                     = var.backup_configuration_start_time
      }
    }

    dynamic "database_flags" {
      for_each = var.database_flags
      content {
        name  = database_flags.value.name
        value = database_flags.value.value
      }
    }
  }

  lifecycle {
    ignore_changes = [settings]
  }
}

resource "google_sql_database" "main" {
  count    = var.database_name != "" ? 1 : 0
  name     = var.database_name
  project  = var.project
  instance = google_sql_database_instance.main.name

  depends_on = [google_sql_database_instance.main]
}

resource "google_sql_user" "main" {
  count    = var.user_name != "" && var.user_password != "" ? 1 : 0
  name     = var.user_name
  instance = google_sql_database_instance.main.name
  project  = var.project
  password = var.user_password

  depends_on = [google_sql_database_instance.main]
}
