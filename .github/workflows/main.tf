terraform {
  required_providers {
    google = {
      source  = "hashicorp/google"
      version = "~> 4.0"
    }
  }


provider "google" {
  project     = "retail-data-pipeline-454921"
  region      = "europe-west1"
  credentials = file("/Users/tomilolaadeyinka/Downloads/retail-data-pipeline-454921-61126dd6d10e.json")
}


resource "google_storage_bucket" "data_lake_bucket" {
  name     = "retail-data-lake-bucket"
  location = "EU"
  force_destroy = true
}

