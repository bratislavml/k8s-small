resource "k8s_manifest" "jmx_exporter_deploy" {
  content    = "${file("${path.module}/jmx-deployment.yaml")}"
}

resource "k8s_manifest" "jmx_exporter_service" {
  content    = "${file("${path.module}/jmx-service.yaml")}"
}