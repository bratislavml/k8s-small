
## Intro

We would like you to:
  - set up a Kubernetes cluster
  - create (or adjust) a couple of applications
  - deploy them
  - generate, then vizualize some meaningful monitoring data

These steps are purposfully high level. After completion we will have a conversation about the results and the paths you've taken to get there. Be ready to present your solution to us and to walk us through the steps taken, explain things you've done and why and the decisions you've made.

## Setup
- set up a local or remote cluster
- install Prometheus and a Postgres database

## Applications
Application 1:
- an application that opens a database connection and sleeps for a random time and exposes any interesting monitoring data via a `/metrics` endpoint (for example, how many connections have been made since boot?)
- feel free to use and adjust the go app provided, or set up an app that does the same in the language/framework of your choice

Application 2:
- deploy a simple JVM based app into the cluster
- choose your own or use https://hub.docker.com/r/bitnami/java-example/
- ensure the JVM can use/access at max 1GB of memory

## Deployment
Deploy two applications into the cluster in a way that you think makes most sense. See if you can come up with a solution that can be easily adjusted for  different environments.

## Monitoring
Pull data from Application 1 into Prometheus. Vizualize the relevant data in any way you like.

## Paths
Ensure the following paths respond correctly:

`https://<cluster-host>/metrics` - the first app's metrics endpoint
`https://<cluster-host>/monitoring` - either Prometheus or whatever else you're using to vizalize the monitoring data

## Bonus
- enable JMX monitoring for the JVM app and pull data into Prometheus