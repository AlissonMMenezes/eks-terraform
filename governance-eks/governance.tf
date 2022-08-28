resource "kubernetes_role" "crm-developers-role" {
  metadata {
    name = "crm-developers"  
    namespace = "crm"  
  }

  rule {
    api_groups     = [""]
    resources      = ["*"]    
    verbs          = ["*"]
  }
  
}

resource "kubernetes_role_binding" "crm-role-bind-users" {
  metadata {
    name      = "crm-developers-role-binding"
    namespace = "crm"
  }
  subject {
    kind      = "Group"
    name      = "crm-developers-group"
    api_group = "rbac.authorization.k8s.io"
  }  
  role_ref {
    api_group = "rbac.authorization.k8s.io"
    kind      = "Role"
    name      = "crm-developers"
  }
  
}

resource "kubernetes_config_map" "aws-config-map" {
  metadata {
    name = "aws-auth"
    namespace = "kube-system"
  }

  data = {
    mapRoles = <<EOF
    null
    EOF
    mapUsers = <<EOF
    - groups:
      - crm-developers-group
      userarn: arn:aws:iam::360560397478:user/alisson-machado
      username: alisson-machado    
    EOF
    }        
}

