terraform {
  cloud {
    organization = "margarita30062001"

    workspaces {
      name = "aws-k8s"
    }
  }
}