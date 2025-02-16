resource "helm_release" "argocd" {
  name             = "argocd"
  repository       = "https://argoproj.github.io/argo-helm"
  chart            = "argo-cd"
  namespace        = "argocd"
  create_namespace = true
  atomic           = true
  values = [<<EOF
server:
  resources:
    limits:
      cpu: 250m
      memory: 500Mi
    requests:
      cpu: 250m
      memory: 500Mi

repoServer:
  resources:
    limits:
      cpu: 250m
      memory: 500Mi
    requests:
      cpu: 250m
      memory: 500Mi

controller:
  resources:
    limits:
      cpu: 250m
      memory: 500Mi
    requests:
      cpu: 250m
      memory: 500Mi
  
redis:
  exporter:
    resources:
      limits:
        cpu: 250m
        memory: 500Mi
      requests:
        cpu: 250m
        memory: 500Mi
  resources:
    limits:
      cpu: 250m
      memory: 500Mi
    requests:
      cpu: 250m
      memory: 500Mi
EOF
  ]
}

locals {
  argo_projects_manifests = split("---", file("../helm/argo-bootstrap/projects.yaml"))
  argo_applications_manifests = split("---", file("../helm/argo-bootstrap/applications.yaml"))
}

resource "kubernetes_manifest" "argo_projects" {
  count     = length(local.argo_projects_manifests)
  depends_on = [helm_release.argocd]
  manifest  = yamldecode(local.argo_projects_manifests[count.index])
}

resource "kubernetes_manifest" "argo_applications" {
  count     = length(local.argo_applications_manifests)
  depends_on = [helm_release.argocd]
  manifest  = yamldecode(local.argo_applications_manifests[count.index])
}