#Cloud sql outuputs

output "self_link" {
  description = "URI completo della risorsa Cloud SQL."
  value       = google_sql_database_instance.sql_database_instance.self_link
}

output "connection_name" {
  description = "Cloud SQL connection string (per Proxy o Connector)."
  value       = google_sql_database_instance.sql_database_instance.connection_name
}

output "dns_name" {
  description = "Primary DNS name dell'istanza."
  value       = google_sql_database_instance.sql_database_instance.dns_name
}

output "dns_names" {
  description = "Lista dei DNS names disponibili."
  value       = google_sql_database_instance.sql_database_instance.dns_names
}

output "dns_names_details" {
  description = "Lista dettagliata di DNS names, tipi e scope."
  value = [
    for d in google_sql_database_instance.sql_database_instance.dns_names : {
      name            = d.name
      connection_type = d.connection_type
      dns_scope       = d.dns_scope
    }
  ]
}

output "service_account_email_address" {
  description = "Service account email associata all'istanza."
  value       = google_sql_database_instance.sql_database_instance.service_account_email_address
}

output "ip_addresses" {
  description = "Lista completa degli indirizzi IP dell'istanza."
  value       = google_sql_database_instance.sql_database_instance.ip_address
}

output "first_ip_address" {
  description = "Primo IP assegnato all'istanza (qualsiasi tipo)."
  value       = google_sql_database_instance.sql_database_instance.first_ip_address
}

output "public_ip_address" {
  description = "Primo IP pubblico (PRIMARY)."
  value       = google_sql_database_instance.sql_database_instance.public_ip_address
}

output "private_ip_address" {
  description = "Primo IP privato (PRIVATE)."
  value       = google_sql_database_instance.sql_database_instance.private_ip_address
}

output "available_maintenance_versions" {
  description = "Lista delle versioni di manutenzione disponibili."
  value       = google_sql_database_instance.sql_database_instance.available_maintenance_versions
}

output "psc_service_attachment_link" {
  description = "URI della Service Attachment PSC dell'istanza."
  value       = google_sql_database_instance.sql_database_instance.psc_service_attachment_link
}

output "instance_type" {
  description = "Tipologia dell'istanza (standalone, read replica, ecc.)."
  value       = google_sql_database_instance.sql_database_instance.instance_type
}

output "settings_version" {
  description = "Versione delle settings per update atomici."
  value       = google_sql_database_instance.sql_database_instance.settings[0].version
}

output "effective_availability_type" {
  description = "Il tipo di availability effettivo riportato dall'API."
  value       = google_sql_database_instance.sql_database_instance.settings[0].effective_availability_type
}

output "server_ca_cert" {
  description = "Certificato CA del server SQL (struttura completa)."
  value       = google_sql_database_instance.sql_database_instance.server_ca_cert
}

output "server_ca_cert_info" {
  description = "Info certificate CA (cert, CN, create time, expiration, sha1)."
  value = [
    for c in google_sql_database_instance.sql_database_instance.server_ca_cert : {
      cert             = c.cert
      common_name      = c.common_name
      create_time      = c.create_time
      expiration_time  = c.expiration_time
      sha1_fingerprint = c.sha1_fingerprint
    }
  ]
}


#Sql database outputs

output "sql_database_id" {
  description = "Identifier for the resource with format: projects/{{project}}/instances/{{instance}}/databases/{{name}}"
  value = try(google_sql_database.sql_database[0].id, null)
}

output "sql_database_self_link" {
  description = "The URI of the created resource."
  value = try(google_sql_database.sql_database[0].self_link, null)
}


#Sql user outputs

output "sql_user_password_wo" {
  description = "Password dello user"
  value = try(google_sql_user.sql_user[0].password_wo, null)
}
