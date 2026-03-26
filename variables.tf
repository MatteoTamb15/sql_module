variable "name" {
  description = "Nome del Cloud SQL instance. Se null, Terraform genera un nome randomico."
  type        = string
}

variable "project" {
  description = "Project ID per Cloud SQL instance."
  type        = string
  default     = null
}

variable "region" {
  description = "Regione dove viene eseguita l'instanza SQL."
  type        = string
  default     = null
}

variable "database_version" {
  description = "Database engine version (MySQL, PostgreSQL, SQL Server)."
  type        = string
}

variable "deletion_protection" {
  description = "Previene che Terraform distrugge accidentalmente l'istanza."
  type        = bool
  default     = false
}

variable "database_name" {
  type    = string
  default = ""
}

variable "user_name" {
  type    = string
  default = ""
}

variable "user_password" {
  type      = string
  sensitive = true
  default   = ""
}

variable "tier" {
  type    = string
  default = "db-f1-micro"
}

variable "availability_type" {
  type    = string
  default = "ZONAL"
}

variable "disk_autoresize" {
  type    = bool
  default = true
}

variable "disk_size" {
  type    = number
  default = 10
}

variable "disk_type" {
  type    = string
  default = "PD_SSD"
}

variable "backup_configuration_enabled" {
  type    = bool
  default = true
}

variable "backup_configuration_binary_log_enabled" {
  type    = bool
  default = false
}

variable "backup_configuration_point_in_time_recovery_enabled" {
  type    = bool
  default = false
}

variable "backup_configuration_start_time" {
  type    = string
  default = "01:00"
}

variable "authorized_networks" {
  type = list(object({
    name  = string
    value = string
  }))
  default = []
}

variable "database_flags" {
  type = list(object({
    name  = string
    value = string
  }))
  default = []
}

variable "settings" {
  type = object({
    tier                             = string
    edition                          = optional(string)
    user_labels                      = optional(map(string))
    activation_policy                = optional(string)
    availability_type                = optional(string)
    collation                        = optional(string)
    connector_enforcement            = optional(string)
    deletion_protection_enabled      = optional(bool)
    enable_google_ml_integration     = optional(bool)
    enable_dataplex_integration      = optional(bool)
    disk_autoresize                  = optional(bool)
    disk_autoresize_limit            = optional(number)
    disk_size                        = optional(number)
    disk_type                        = optional(string)
    data_disk_provisioned_iops       = optional(number)
    data_disk_provisioned_throughput = optional(number)
    node_count                       = optional(number)
    pricing_plan                     = optional(string)
    time_zone                        = optional(string)
    retain_backups_on_delete         = optional(bool)

    advanced_machine_features = optional(object({
      threads_per_core = optional(number)
    }))

    database_flags = optional(list(object({
      name  = string
      value = string
    })))

    active_directory_config = optional(object({
      domain = string
    }))

    data_cache_config = optional(object({
      data_cache_enabled = optional(bool)
    }))

    deny_maintenance_period = optional(list(object({
      start_date = string
      end_date   = string
      time       = string
    })))

    sql_server_audit_config = optional(object({
      bucket             = optional(string)
      upload_interval    = optional(string)
      retention_interval = optional(string)
    }))

    backup_configuration = optional(object({
      binary_log_enabled             = optional(bool)
      enabled                        = optional(bool)
      start_time                     = optional(string)
      point_in_time_recovery_enabled = optional(bool)
      location                       = optional(string)
      transaction_log_retention_days = optional(number)

      backup_retention_settings = optional(object({
        retained_backups = optional(number)
        retention_unit   = optional(string)
      }))
    }))

    ip_configuration = optional(object({
      ipv4_enabled                            = optional(bool)
      private_network                         = optional(string)
      ssl_mode                                = optional(string)
      server_ca_mode                          = optional(string)
      server_ca_pool                          = optional(string)
      custom_subject_alternative_names        = optional(list(string))
      allocated_ip_range                      = optional(string)
      enable_private_path_for_google_services = optional(bool)

      authorized_networks = optional(list(object({
        name            = optional(string)
        value           = string
        expiration_time = optional(string)
      })))

      psc_config = optional(list(object({
        psc_enabled               = optional(bool)
        allowed_consumer_projects = optional(list(string))
      })))
    }))

    psc_auto_connections = optional(object({
      consumer_network           = string
      network_attachment_uri     = optional(string)
      consumer_service_project_id = optional(string)
    }))

    location_preference = optional(object({
      follow_gae_application = optional(string)
      zone                   = optional(string)
      secondary_zone         = optional(string)
    }))

    maintenance_window = optional(object({
      day          = optional(number)
      hour         = optional(number)
      update_track = optional(string)
    }))

    insights_config = optional(object({
      query_insights_enabled  = optional(bool)
      query_string_length     = optional(number)
      record_application_tags = optional(bool)
      record_client_address   = optional(bool)
      query_plans_per_minute  = optional(number)
    }))

    password_validation_policy = optional(object({
      min_length                  = optional(number)
      complexity                  = optional(string)
      reuse_interval              = optional(number)
      disallow_username_substring = optional(bool)
      password_change_interval    = optional(number)
      enable_password_policy      = optional(bool)
    }))

    connection_pool_config = optional(object({
      connection_pooling_enabled = optional(bool)
      flags = optional(list(object({
        name  = string
        value = string
      })))
    }))
  })
}

variable "clone" {
  type = object({
    source_instance_name = string
    point_in_time        = optional(string)
    preferred_zone       = optional(string)
    database_names       = optional(list(string))
    allocated_ip_range   = optional(string)
  })
  default = null
}

variable "restore_backup_context" {
  type = object({
    backup_run_id = number
    instance_id   = optional(string)
    project       = optional(string)
  })
  default = null
}

variable "replica_configuration" {
  type = object({
    cascadable_replica        = optional(bool)
    ca_certificate            = optional(string)
    client_certificate        = optional(string)
    client_key                = optional(string)
    connect_retry_interval    = optional(number)
    dump_file_path            = optional(string)
    failover_target           = optional(bool)
    master_heartbeat_period   = optional(number)
    password                  = optional(string)
    ssl_cipher                = optional(string)
    username                  = optional(string)
    verify_server_certificate = optional(bool)
  })
  default = null
}

variable "replication_cluster" {
  type = object({
    psa_write_endpoint         = optional(string)
    failover_dr_replica_name   = optional(string)
    dr_replica                 = optional(bool)
  })
  default = null
}
