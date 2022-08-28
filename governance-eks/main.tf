resource "kubernetes_namespace" "projects-namespaces" {
  for_each = toset(["poc", "mvp", "crm"])
  metadata {
    name = each.value
  }
}