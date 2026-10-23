
# Create Cluster definition

resource "kubernetes_secret" "registration" {
  metadata {
    name      = "cluster-${var.cluster_name}"
    namespace = "argocd"

    labels = merge({ "argocd.argoproj.io/secret-type" : "cluster" }, var.labels)

    annotations = var.annotations
  }

  type = "Opaque"

  data = {
    name   = var.cluster_name
    server = var.api_endpoint
    config = jsonencode({
      bearerToken = kubernetes_secret.argocd-manager.data["token"]
      tlsClientConfig = {
        caData = var.ca
      }
    })
    token = kubernetes_secret.argocd-manager.data["token"]
    ca    = var.ca
  }

  provider = kubernetes.source
}



