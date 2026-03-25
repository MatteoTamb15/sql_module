resource "google_sql_user" "sql_user" {
  count    = var.user_name != "" && var.user_password != "" ? 1 : 0
  name     = var.user_name
  instance = google_sql_database_instance.main.name
  project  = var.project
  password = var.user_password

  depends_on = [google_sql_database_instance.main]
}