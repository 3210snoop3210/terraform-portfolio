terraform {
  backend "remote" {
    organization = "margarita30062001"
        workspaces {
            name = "aws-dev-repo"
        }
    }
}