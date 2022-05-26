resource "google_sql_database_instance" "camunda-db" {
  name             = "camunda-db-postgres"
  database_version = "POSTGRES_11"
  region           = local.config.region

  settings {
    backup_configuration {
      enabled = true
    }
    # Very small instance for testing.
    tier = "db-f1-micro"
    ip_configuration {
      require_ssl = true
        ipv4_enabled = true
    }
  }
}

resource "google_sql_user" "user" {
  name     = "camunda"
  instance = google_sql_database_instance.camunda-db.name
  password = "futurice"
}

resource "google_sql_database" "database" {
  name     = "camunda"
  instance = google_sql_database_instance.camunda-db.name
}
