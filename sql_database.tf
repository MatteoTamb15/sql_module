resource "google_sql_database" "main" {
  count  = var.database_name != "" ? 1 : 0
  name   = var.database_name
  project  = var.project
  instance = google_sql_database_instance.main.name

  depends_on = [google_sql_database_instance.main]
}