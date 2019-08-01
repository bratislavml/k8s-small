# k8s-small

## Setup kubeconfig
provider "k8s" {
  kubeconfig = "/path-to/.kube/config"
}

## Setup K8s cluster in GCE using Terraform (without the state)
Run following commands:

 `cd k8s-small`
 
 `terraform plan`
 
 `terraform apply`

## Get credentials for GCE K8S cluster
`gcloud container clusters get-credentials k8s-small  --zone=us-central1`

## Install Postgres database
 `cd k8s-small/candidate/postgres/`
 
 `terraform plan`
 
 `terraform apply`

## Install Prometheus
 `cd k8s-small/candidate/prometheus/`
 
 `terraform plan`
 
 `terraform apply`

## Deploy Application 1 (contiamo-app):

Application 1 - description:
- an application that opens a database connection and sleeps for a random time and exposes any interesting monitoring data via a `/metrics` endpoint (for example, how many connections have been made since boot?)

Run:

 `cd k8s-small/candidate/app/`

 `export PROJECT_ID="$(gcloud config get-value project -q)"`

 `docker build -t gcr.io/${PROJECT_ID}/contiamo-app:v2 .`
 
 `docker push gcr.io/${PROJECT_ID}/contiamo-app:v2`
 
 `terraform plan`
 
 `terraform apply`
 
## Deploy Application 2 (java-app):

Application 2 - description: simple JVM based app into the cluster use https://hub.docker.com/r/bitnami/java-example/

 `cd k8s-small/candidate/java-app/`
 
 `docker build -t gcr.io/${PROJECT_ID}/java-app:v1 .`
 
 `docker push gcr.io/${PROJECT_ID}/java-app:v1`
 
 `terraform plan`
 
 `terraform apply`
 
## TODO:

## Paths
Ensure the following paths respond correctly:

`https://<cluster-host>/metrics` - the first app's metrics endpoint
`https://<cluster-host>/monitoring` - either Prometheus or whatever else you're using to vizalize the monitoring data

This can be done with ingress. 

## Bonus
- enable JMX monitoring for the JVM app and pull data into Prometheus`
