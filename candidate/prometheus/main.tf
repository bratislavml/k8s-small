####### Creating Namespace ####
#resource "k8s_manifest" "monitoring_namespace" {
#  content = "${file("${path.module}/namespace.yaml")}"
#}

####### Creating Cluster Roles for prometheus ####
#resource "k8s_manifest" "prometheus_crole" {
#  namespace = "${k8s_manifest.monitoring_namespace.name}"
#  content   = "${file("${path.module}/prometheus-resources/clusterrole.yaml")}"
#}

####### Creating Cluster Rolebinding for prometheus ####
#resource "k8s_manifest" "prometheus_crb" {
#  namespace = "${k8s_manifest.monitoring_namespace.name}"
#  content   = "${file("${path.module}/prometheus-resources/clusterrolebinding.yaml")}"
#}

######### Prometheus ConfigMap #####
resource "k8s_manifest" "prometheus_ConfigMap" {
  content = "${file("${path.module}/config-map.yaml")}"
}

########## prometheus Deployment #####
resource "k8s_manifest" "prometheus_deploy" {
  depends_on = ["k8s_manifest.prometheus_ConfigMap"]
  content    = "${file("${path.module}/prometheus-deployment.yaml")}"
}

########## prometheus Service #####
resource "k8s_manifest" "prometheus_svc" {
  depends_on = ["k8s_manifest.prometheus_deploy"]
  content    = "${file("${path.module}/prometheus-service.yaml")}"
}
