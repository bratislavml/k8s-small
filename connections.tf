provider "google" {
  credentials = "${file("~/.gce/t-dragon-246512-3dad962d9191.json")}"
  region      = "us-central1"
}
