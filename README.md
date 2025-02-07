# infra-reference
My infra reference repository for learning and testing

## Table of Contents

- [Introduction](#introduction)
- [Prerequisites](#prerequisites)
- [Setup](#setup)
- [Running the Service](#running-the-service)
- [Building the Docker Image](#building-the-docker-image)

## Introduction
Putting together a ground up infra repo for fun, practice, and learning. I often don't get the chance to do things start to finish in a team environment, so I'd like to experience every aspect of configuring an infra stack. I'm hoping to complete the majority of this in a one-week span.

## Prerequisites
- Helm v3.17.0
- Terraform v1.9.8
- Kubectl
- gcloud

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
terraform init -backend-config="bucket=bdor528-infra-reference-dev" -backend-config="prefix=terraform/state/"
```

```sh
terraform workspace new infra-reference-dev
terraform workspace select infra-reference-dev
```

Finally update `config.infra.yaml` 
Set `project.infra-reference-dev.project_id` to your project id.

# Tools

## Traefik
Docs: https://doc.traefik.io/traefik/getting-started/install-traefik/

## Argo CD
Install and setup ArgoCD
Docs: https://argo-cd.readthedocs.io/en/stable/getting_started/

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

