
resource "kubernetes_namespace" "argocd" {
  metadata {
    name = "argocd"
  }

  provider = kubernetes.target
}


resource "kubernetes_service_account" "argocd-manager" {
  metadata {
    name      = "argocd-manager"
    namespace = kubernetes_namespace.argocd.metadata[0].name
  }

  provider = kubernetes.target
}

resource "kubernetes_cluster_role_binding" "argocd-manager" {
  metadata {
    name = "argocd-manager"
  }

  role_ref {
    api_group = "rbac.authorization.k8s.io"
    kind      = "ClusterRole"
    name      = "cluster-admin"
  }

  subject {
    kind      = "ServiceAccount"
    name      = kubernetes_service_account.argocd-manager.metadata[0].name
    namespace = kubernetes_service_account.argocd-manager.metadata[0].namespace
  }

  provider = kubernetes.target
}

resource "kubernetes_secret" "argocd-manager" {
  metadata {
    name      = "argocd-manager-token"
    namespace = kubernetes_namespace.argocd.metadata[0].name
    annotations = {
      "kubernetes.io/service-account.name" = kubernetes_service_account.argocd-manager.metadata[0].name
    }
  }

  type                           = "kubernetes.io/service-account-token"
  wait_for_service_account_token = true

  provider = kubernetes.target
}
