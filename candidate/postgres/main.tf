provider "kubernetes" {}

resource "kubernetes_secret" "postgres" {
  metadata {
    name = "postgres"
  }

  data = {
    username = "postgres"
    password = "2bsybsy1g8sg12721gb"
  }

  type = "kubernetes.io/basic-auth"
}

resource "k8s_manifest" "postgres_volumeclaim" {
  content = "${file("${path.module}/postgres-volumeclaim.yaml")}"
}

resource "k8s_manifest" "postgres" {
  content = "${file("${path.module}/postgres.yaml")}"
}

resource "k8s_manifest" "postgres-service" {
  content = "${file("${path.module}/postgres-service.yaml")}"
}
