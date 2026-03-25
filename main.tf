resource "google_sql_database_instance" "main" {
  name                = var.name
  project             = var.project
  database_version    = var.database_version
  region              = var.region
  deletion_protection = var.deletion_protection

  settings {
    tier                            = var.tier
    edition                         = try(var.settings.edition, null)
    user_labels                     = try(var.settings.user_labels, {})
    activation_policy               = try(var.settings.activation_policy, null)
    availability_type               = var.availability_type
    collation                       = try(var.settings.collation, null)
    connector_enforcement           = try(var.settings.connector_enforcement, null)
    disk_autoresize                 = var.disk_autoresize
    disk_autoresize_limit           = try(var.settings.disk_autoresize_limit, null)
    disk_size                       = var.disk_size
    disk_type                       = var.disk_type
    pricing_plan                    = try(var.settings.pricing_plan, null)
    time_zone                       = try(var.settings.time_zone, null)
    retain_backups_on_delete        = try(var.settings.retain_backups_on_delete, null)

    dynamic "ip_configuration" {
      for_each = length(var.authorized_networks) > 0 ? [true] : []
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
      for_each = var.backup_configuration_enabled ? [true] : []
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

    dynamic "location_preference" {
      for_each = try(var.settings.location_preference, null) != null ? [var.settings.location_preference] : []
      content {
        zone = location_preference.value.zone
        secondary_zone = location_preference.value.secondary_zone
      }
    }

    dynamic "maintenance_window" {
      for_each = try(var.settings.maintenance_window, null) != null ? [var.settings.maintenance_window] : []
      content {
        day  = maintenance_window.value.day
        hour = maintenance_window.value.hour
        update_track = maintenance_window.value.update_track
      }
    }
  }

  lifecycle {
    ignore_changes = [settings]
  }
}

resource "google_sql_database" "main" {
  count  = var.database_name != "" ? 1 : 0
  name   = var.database_name
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
