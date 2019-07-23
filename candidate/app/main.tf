provider "kubernetes" {}

resource "k8s_manifest" "deployment" {
  content = "${file("${path.module}/deployment.yaml")}"
}

resource "k8s_manifest" "app-service" {
  content = "${file("${path.module}/app-service.yaml")}"
}
