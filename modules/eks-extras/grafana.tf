
resource "kubernetes_namespace" "prometheus" {
  metadata {
    name = "terraform-prometheus"
  }
}

resource "kubernetes_namespace" "grafana" {
  metadata {
    name = "terraform-grafana"
  }
}

resource "helm_release" "prometheus" {
  depends_on = [kubernetes_namespace.prometheus]
  name       = "prometheus"
  repository = "https://prometheus-community.github.io/helm-charts"
  chart      = "prometheus"
  namespace  = kubernetes_namespace.prometheus.metadata.0.name
  set {
    name  = "server.persistentVolume.enabled"
    value = "true"
  }

    set {
    name  = "alertmanager.persistentVolume.enabled"
    value = "true"
  }

    set {
    name  = "alertmanager.persistentVolume.storageClass"
    value = "standard"
   }

  set {
    name  = "server.persistentVolume.storageClass"
    value = "standard"
   }

set {
    name  = "server.retention"
    value = "30d"
   }
#   set {
#     name  = "server.persistentVolume.size"
#     value = "8Gi"
#   }

#   set {
#     name  = "server.service.type"
#     value = "LoadBalancer"
#   }
  
#   set {
#     name  = "server.service.port"
#     value = "80"
#   }

#   set {
#     name  = "alertmanager.persistentVolume.size"
#     value = "2Gi"
#   }

#   set {
#     name  = "kube-state-metrics.enabled"
#     value = "false"
#   }
}

resource "helm_release" "grafana" {
  depends_on = [ kubernetes_namespace.grafana ]
  name       = "grafana"
  repository = "https://grafana.github.io/helm-charts"
  chart      = "grafana"
  namespace  = kubernetes_namespace.grafana.metadata.0.name

  set {
    name  = "adminPassword"
    value = "42Gears@123"
  }
  set {
    name  = "persistence.storageClassName"
    value = "standard"
  }
  set {
    name  = "persistence.enabled"
    value = "true"
  }

  set {
    name  = "service.type"
    value = "LoadBalancer"
  }
  
  set {
    name  = "service.port"
    value = "80"
  }
}
