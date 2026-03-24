
variable "project" {
  description = "GCP project ID"
  type        = string
}

variable "name" {
  description = "Instance name"
  type        = string
}

variable "region" {
  description = "Region"
  type        = string
}

variable "database_version" {
  description = "Database version"
  type        = string
}

variable "deletion_protection" {
  description = "Deletion protection"
  type        = bool
  default     = false
}

variable "labels" {
  type    = map(string)
  default = {}
}

variable "settings_version" {
  description = "Settings version"
  type        = number
  default     = 2
}

variable "settings" {
  type = object({
    tier                             = string
    edition                          = optional(string)
    user_labels                      = optional(map(string), {})
    auto_upgrade_enabled             = optional(bool)
    activation_policy                = optional(string)
    availability_type                = optional(string)
    collation                        = optional(string)
    connector_enforcement            = optional(string)
    data_api_access                  = optional(string)
    deletion_protection_enabled      = optional(bool)
    enable_google_ml_integration     = optional(bool)
    enable_dataplex_integration      = optional(bool)
    disk_autoresize                  = optional(bool)
    disk_autoresize_limit            = optional(number)
    disk_size                        = optional(number)
    disk_type                        = optional(string)
    data_disk_provisioned_iops       = optional(string)
    data_disk_provisioned_throughput = optional(string)
    pricing_plan                     = optional(string)
    time_zone                        = optional(string)
    retain_backups_on_delete         = optional(string)
  })
  default = null
}

variable "maintenance_version" {
    description = "maintenance_version"
  type    = string
  default = null
}

variable "master_instance_name" {
    description = "master_instance_name"
  type    = string
  default = null
}

variable "replica_names" {
    description = "replica_names"
  type    = list(string)
  default = []
}

variable "root_password" {
    description = "root_password"
  type    = string
  default = null
}

variable "root_password_wo" {
    description = "root_password_wo"
  type    = string
  default = null
}

variable "root_password_wo_version" {
    description = "root_password_wo_version"
  type    = string
  default = null
}

variable "encryption_key_name" {
    description = "encryption_key_name"
  type    = string
  default = null
}

variable "final_backup_description" {
    description = "final_backup_description"
  type    = bool
  default = true
}

variable "clone" {
  description = "Optional clone configuration block for Cloud SQL instance."
  type = object({
    source_instance_name          = string
    source_project                = optional(string)
    database_names                = optional(list(string))
    allocated_ip_range            = optional(string)
    source_instance_deletion_time = optional(string)
    restore_backup_context = optional(object({
      backup_run_id = number
      instance_id   = optional(string)
      project       = optional(string)
    }))
    replication_cluster = optional(object({
      psa_write_endpoint       = optional(string)
      failover_dr_replica_name = optional(string)
      dr_replica               = optional(bool)
    }))
  })

  default = null
}

variable "tier" {
  type    = string
  default = "db-f1-micro"
}

variable "activation_policy" {
  type    = string
  default = "ALWAYS"
}

variable "availability_type" {
  type    = string
  default = "ZONAL"
}

variable "pricing_plan" {
  type    = string
  default = "PER_USE"
}

variable "auto_upgrade_indexes" {
  type    = bool
  default = false
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

variable "data_cache_enabled" {
  type    = bool
  default = false
}

variable "data_cache_size_gb" {
  type    = number
  default = 0.1
}

variable "maintenance_window_day" {
  type    = number
  default = 7
}

variable "maintenance_window_hour" {
  type    = number
  default = 3
}

variable "maintenance_window_update_track" {
  type    = string
  default = "stable"
}

variable "location_preference_zone" {
  type    = string
  default = "a"
}

variable "location_preference_follow_gce_zone" {
  type    = bool
  default = false
}

variable "backup_configuration_enabled" {
  type    = bool
  default = true
}

variable "backup_configuration_binary_log_enabled" {
  type    = bool
  default = false
}

variable "backup_configuration_retention_days" {
  type    = number
  default = 7
}

variable "backup_configuration_point_in_time_recovery_enabled" {
  type    = bool
  default = false
}

variable "backup_configuration_start_time" {
  type    = string
  default = "01:00"
}

variable "backup_configuration_location" {
  type    = string
  default = null
}

variable "backup_configuration_kind" {
  type    = string
  default = null
}

variable "ip_configuration_ipv4_enabled" {
  type    = bool
  default = false
}

variable "ip_configuration_require_ssl" {
  type    = bool
  default = true
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

