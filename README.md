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
-backend-config="bucket=bdor528-infra-reference-dev" \ 
-backend-config="prefix=terraform/state/"
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

### Minikube

For local development and cost savings, you can use minikube instead

```sh
minikube start --driver=docker --profile=infra-reference-dev
```

```sh
minikube stop --profile=infra-reference-dev
```

# Stack

## Traefik
Docs: https://doc.traefik.io/traefik/getting-started/install-traefik/

## Argo CD

### Install
Docs: https://argo-cd.readthedocs.io/en/stable/getting_started/

Install Argo
```sh
cd helm
helm repo add argo-cd https://argoproj.github.io/argo-helm  
helm dep update argo-cd/
helm install argo-cd argo-cd/ --namespace argocd --create-namespace
```
Verify the install
```sh
kubectl port-forward svc/argo-cd-argocd-server 8080:443
kubectl get secret argocd-initial-admin-secret -o jsonpath="{.data.password}" | base64 -d
```

Install Argo Image Updater
```sh
kubectl apply -n argocd -f https://raw.githubusercontent.com/argoproj-labs/argocd-image-updater/stable/manifests/install.yaml
```

## Grafana OSS
Docs: https://grafana.com/docs/grafana/latest/setup-grafana/installation/helm/

## Tekton

### Operator Install

Docs: https://tekton.dev/docs/operator/

```sh
kubectl apply -f https://storage.googleapis.com/tekton-releases/operator/latest/release.yaml
```

# Plans

- Build out microservice chart
- 

