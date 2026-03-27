resource "google_sql_database_instance" "sql_database_instance" {
  name                = var.name
  project             = var.project
  database_version    = var.database_version
  region              = var.region
  deletion_protection = var.deletion_protection

  dynamic "settings" {
    for_each = var.settings == null ? [] : [var.settings]
    content {
      tier        = settings.value.tier
      edition     = settings.value.edition
      user_labels = settings.value.user_labels
      activation_policy     = settings.value.activation_policy
      availability_type     = try(settings.value.availability_type, var.availability_type)
      collation             = settings.value.collation
      connector_enforcement = settings.value.connector_enforcement
      deletion_protection_enabled  = settings.value.deletion_protection_enabled
      enable_google_ml_integration = settings.value.enable_google_ml_integration
      enable_dataplex_integration  = settings.value.enable_dataplex_integration
      disk_autoresize              = try(settings.value.disk_autoresize, var.disk_autoresize)
      disk_autoresize_limit        = settings.value.disk_autoresize_limit
      disk_size                    = try(settings.value.disk_size, var.disk_size)
      disk_type                    = try(settings.value.disk_type, var.disk_type)
      pricing_plan             = settings.value.pricing_plan
      time_zone                = settings.value.time_zone
      retain_backups_on_delete = settings.value.retain_backups_on_delete

      dynamic "advanced_machine_features" {
        for_each = try(settings.value.advanced_machine_features, null) != null ? [settings.value.advanced_machine_features] : []
        content {
          threads_per_core = advanced_machine_features.value.threads_per_core
        }
      }

      dynamic "database_flags" {
        for_each = var.database_flags
        content {
          name  = database_flags.value.name
          value = database_flags.value.value
        }
      }

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
        for_each = [var.backup_configuration_enabled]
        content {
          enabled                        = true
          binary_log_enabled             = var.backup_configuration_binary_log_enabled
          point_in_time_recovery_enabled = var.backup_configuration_point_in_time_recovery_enabled
          start_time                     = var.backup_configuration_start_time
        }
      }

      dynamic "location_preference" {
        for_each = try(settings.value.location_preference, null) != null ? [settings.value.location_preference] : []
        content {
          zone           = location_preference.value.zone
          secondary_zone = location_preference.value.secondary_zone
        }
      }

      dynamic "maintenance_window" {
        for_each = try(settings.value.maintenance_window, null) != null ? [settings.value.maintenance_window] : []
        content {
          day          = maintenance_window.value.day
          hour         = maintenance_window.value.hour
          update_track = maintenance_window.value.update_track
        }
      }
    }
  }

  dynamic "clone" {
    for_each = var.clone != null ? [var.clone] : []
    content {
      source_instance_name = clone.value.source_instance_name
    }
  }

  dynamic "replica_configuration" {
    for_each = var.replica_configuration != null ? [var.replica_configuration] : []
    content {
      failover_target           = try(replica_configuration.value.failover_target, null)
      connect_retry_interval    = try(replica_configuration.value.connect_retry_interval, null)
      dump_file_path            = try(replica_configuration.value.dump_file_path, null)
      master_heartbeat_period   = try(replica_configuration.value.master_heartbeat_period, null)
      ssl_cipher                = try(replica_configuration.value.ssl_cipher, null)
      username                  = try(replica_configuration.value.username, null)
      verify_server_certificate = try(replica_configuration.value.verify_server_certificate, null)
    }
  }

  lifecycle {
    ignore_changes = [settings]
  }
}
