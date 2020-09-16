terraform {
  backend "gcs" {
    bucket  = "tf-state-prod-gcp"
    prefix  = "terraform/state"
  }
}
