terraform {
  required_providers {
    kubernetes = {
      source  = "hashicorp/kubernetes"
      version = "2.13.0"
    }
  }
  backend "s3" {
    bucket = "devopsautomations"
    key    = "states/k8s.tfstate"
    region = "us-east-1"
  }
}

provider "kubernetes" {
  config_path    = "~/.kube/config"
}