output "instance_id" {
  value = google_sql_database_instance.main.id
}

output "instance_name" {
  value = google_sql_database_instance.main.name
}

output "connection_name" {
  value = google_sql_database_instance.main.connection_name
}

output "public_ip_address" {
  value = google_sql_database_instance.main.public_ip_address
}

output "private_ip_address" {
  value = google_sql_database_instance.main.private_ip_address
}

output "service_account_email_address" {
  value = google_sql_database_instance.main.service_account_email_address
}

output "proxy_connection_string" {
  value = "projects/${coalesce(var.project, data.google_project.project.project_id)}/instances/${coalesce(var.name, google_sql_database_instance.main.name)}"
}

data "google_project" "project" {}

output "database_name" {
  value = var.database_name
}

output "user_name" {
  value = var.user_name
}

