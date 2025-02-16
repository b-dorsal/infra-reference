# infra-reference
My infra reference repository for learning and testing

## Table of Contents

- [Introduction](#introduction)
- [Prerequisites](#prerequisites)
- [Setup](#setup)
- [Stack](#stack)

## Introduction
Putting together a ground up infra repo for fun, practice, and learning. I often don't get the chance to do things start to finish in a team environment, so I'd like to experience every aspect of configuring an infra stack. I'm hoping to complete the majority of this in a one-week span.

## Prerequisites
- Helm v3.17.0
- Terraform v1.9.8
- Kubectl
- gcloud
- minikube (optional)

## Setup
### gcloud
Given: an existing project
Create a configuration named with the project name.

```sh
gcloud init
```
Create a bucket for Terraform state files

### Terraform

Initialize Terraform with the state files bucket name

```sh
cd terraform
terraform init \
--backend-config="bucket=bdor528-infra-reference-dev" \ 
--backend-config="prefix=terraform/state/"
```

```sh
terraform workspace new infra-reference-dev
terraform workspace select infra-reference-dev
```
```sh
terraform plan
terraform apply
# and before bed
terraform destroy
```

Finally update `config/config.infra.yaml` 
Set `project.infra-reference-dev.project_id` to your project id.

Auth to the cluster with GCloud
```sh
gcloud container clusters get-credentials CLUSTER_NAME --region=COMPUTE_REGION
```


### Minikube

For local development and cost savings, you can use minikube instead

```sh
minikube start --driver=docker --profile=infra-reference-dev
```

Enable the Ingress Add-On
```sh
minikube addons enable ingress --profile=infra-reference-dev
```

```sh
minikube stop --profile=infra-reference-dev
```

### Traefik
Docs: https://doc.traefik.io/traefik/getting-started/install-traefik/

Values: https://github.com/traefik/traefik-helm-chart

### Tekton

Docs: https://tekton.dev/docs/operator/

Install Tekton Operator
```sh
kubectl apply -f https://storage.googleapis.com/tekton-releases/operator/latest/release.yaml
```

```sh
kubectl apply -f https://api.hub.tekton.dev/v1/resource/tekton/task/docker-build/0.1/raw -n cicd
kubectl apply -f https://api.hub.tekton.dev/v1/resource/tekton/task/git-clone/0.9/raw -n cicd
```

`Todo: Tekton needs to auth to push to dockerhub or workload identity to push to Artifact Registry.`

### Argo CD

Docs: https://argo-cd.readthedocs.io/en/stable/getting_started/

Values: https://github.com/argoproj/argo-helm/blob/main/charts/argo-cd/values.yaml

Install Argo Image Updater
```sh
kubectl apply -n argocd -f https://raw.githubusercontent.com/argoproj-labs/argocd-image-updater/stable/manifests/install.yaml
```

Bootstrap Argo with our dev environment

`To-do: this needs to be a chart`
```sh
cd helm/argo-bootstrap
kubectl apply -f projects.yaml -n argocd
kubectl apply -f applications.yaml -n argocd
```

## Grafana OSS
Docs: https://grafana.com/docs/grafana/latest/setup-grafana/installation/helm/

`Todo: we need to configure this more to persist data`


Install Prometheus

`Todo: coded scrape configs`

Add prometheus scrape config
```sh
scrape_configs:
  - job_name: 'tekton'
    static_configs:
      - targets: 
        - tekton-pipelines-controller.tekton-pipelines.svc.cluster.local:9090
```

Setup Loki for log collection
Docs: https://grafana.com/blog/2023/04/12/how-to-collect-and-query-kubernetes-logs-with-grafana-loki-grafana-and-grafana-agent/

`Todo: Continue this setup when we code the backlog. I dont want to setup the log storage yet.`

```sh
kubectl create ns loki
```

In Grafana UI add prometheus datasource at `http://prometheus-server.monitoring.svc.cluster.local`

# Plans

- Build out microservice chart
- Improve sample-service capabilities for demonstration
- Move secrets to GCP Secret Manager
- Setup Grafana & metrics collection
