resource "google_sql_database" "sql_database" {
  provider = google.cloud_sql

  count    = var.database_name != "" ? 1 : 0
  
  name     = var.database_name
  project  = var.project
  instance = google_sql_database_instance.sql_database_instance.name

  depends_on = [google_sql_database_instance.sql_database_instance]
}
