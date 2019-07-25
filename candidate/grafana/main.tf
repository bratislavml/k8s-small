resource "k8s_manifest" "grafana_pvc" {
  content = "${file("${path.module}/pvc.yaml")}"
}

resource "k8s_manifest" "grafana_deployment" {
  content = "${file("${path.module}/deployment.yaml")}"
}

resource "k8s_manifest" "grafana_service" {
  content = "${file("${path.module}/service.yaml")}"
}