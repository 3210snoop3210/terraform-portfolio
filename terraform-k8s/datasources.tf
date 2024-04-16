data "terraform_remote_state" "kubeconfig" {
    backend = "remote"
    config = {
        organization = "margarita30062001"
        workspaces = {
            name ="aws-dev"
        }
    }
}