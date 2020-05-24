# k8s-small

## Terraform installation

Install Terraform by following this [guide](https://www.terraform.io/downloads.html).

## Go installation

Purpose :- We are installing GO to support custom Kubernetes resource type ‘K8s_manifest’ for resources not supported by terraform.
Install GO using below commands. (GO version > 1.9 is required)
```
curl -O https://storage.googleapis.com/golang/go1.11.2.linux-amd64.tar.gz
tar -xvf go1.11.2.linux-amd64.tar.gz
sudo mv go /usr/local
```

Set Go’s root value, which tells Go where to look for its files.
```
sudo vi ~/.profile
```

Add the below environment variables at the bottom in the opened profile file
```
export GOPATH=$HOME/work
export PATH=$PATH:/usr/local/go/bin:$GOPATH/bin
```

Run the below command as well to refresh your profile
```
source ~/.profile
```
Verify your installation by
```
go version
```
## Export env variables

This variables are required for terraform to authenticate with GCP project using ‘admin-sa’ service account.
You may require to export them with new terminal sessions.

```
export GOOGLE_APPLICATION_CREDENTIALS="/path/to/admin-sa-key.json"
```
GOPATH variable is required for the installation directory of GO.
```
export GOPATH=$HOME/work
export PATH=$PATH:/usr/local/go/bin:$GOPATH/bin
```

## K8s_manifest setup

Get this provider on your local system by running below command.
This will take significant time to get all dependencies required by go for terraform usage.

```
go get -u github.com/harishsearce/terraform-provider-k8s
```
Once done create/update the ‘~/.terraformrc’ file with below lines :

```
providers { k8s = "$GOPATH/bin/terraform-provider-k8s" }
```

## Terraform in action :

Set the Kubeconfig paths in main.tf providers as per local file system.
Generally /home/foo/.kube/config

```
provider "k8s" {
  kubeconfig = "/path/to/kubeconfig"
}

provider "kubernetes" {
  config_path = "/path/to/kubeconfig"
}
```


## Setup kubeconfig
provider "k8s" {
  kubeconfig = "/path-to/.kube/config"
}

## Setup K8s cluster in GCE using Terraform (without the remote state)
Run following commands:

 `cd k8s-small/cluster`
 
 `terraform plan -var-file="env/dev.tfvars"`
 
 `terraform apply -var-file="env/dev.tfvars"`

## Get credentials for GCE K8S cluster
`gcloud container clusters get-credentials k8s-small  --zone=us-central1`

## Install Postgres database
 `cd k8s-small/service/postgres/`
 
 `terraform plan`
 
 `terraform apply`

## Install Prometheus
 `cd k8s-small/service/prometheus/`
 
 `terraform plan`
 
 `terraform apply`

## Deploy Application 1 (contiamo-app):

Application 1 - description:
- an application that opens a database connection and sleeps for a random time and exposes any interesting monitoring data via a `/metrics` endpoint (for example, how many connections have been made since boot?)

Run:

 `cd k8s-small/service/app/`

 `export PROJECT_ID="$(gcloud config get-value project -q)"`

 `docker build -t gcr.io/${PROJECT_ID}/contiamo-app:v2 .`
 
 `docker push gcr.io/${PROJECT_ID}/contiamo-app:v2`
 
 `terraform plan`
 
 `terraform apply`
 
## Deploy Application 2 (java-app):

Application 2 - description: simple JVM based app into the cluster use https://hub.docker.com/r/bitnami/java-example/

 `cd k8s-small/service/java-app/`
 
 `docker build -t gcr.io/${PROJECT_ID}/java-app:v1 .`
 
 `docker push gcr.io/${PROJECT_ID}/java-app:v1`
 
 `terraform plan`
 
 `terraform apply`
 
## JMX exporter
  
 
## TODO:

## Paths
Ensure the following paths respond correctly:

`https://<cluster-host>/metrics` - the first app's metrics endpoint
`https://<cluster-host>/monitoring` - either Prometheus or whatever else you're using to vizalize the monitoring data

This can be done with ingress. 

## Bonus
- enable JMX monitoring for the JVM app and pull data into Prometheus`

NOTE: ajmo ponovo