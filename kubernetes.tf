resource "google_container_cluster" "primary" {
  name               = "${var.cluster_name}"
  initial_node_count = "${var.gcp_cluster_count}"
  location           = "us-central1"
  project            = "t-dragon-246512"

  remove_default_node_pool = true

  master_auth {
    username = "${var.linux_admin_username}"
    password = "${var.linux_admin_password}}"
  }


}

resource "google_container_node_pool" "primary_nodes" {
  name = "primaty-node-pool"
  location = "us-central1"
  project  = "t-dragon-246512"
  cluster = "${google_container_cluster.primary.name}"
  node_count = 1

  node_config {
    preemptible = true
    machine_type = "n1-standard-1"


    oauth_scopes = [
      "https://www.googleapis.com/auth/compute",
      "https://www.googleapis.com/auth/devstorage.read_only",
      "https://www.googleapis.com/auth/logging.write",
      "https://www.googleapis.com/auth/monitoring",
    ]
  }


}