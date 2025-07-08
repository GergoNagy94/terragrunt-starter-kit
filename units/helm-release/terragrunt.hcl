terraform {
  source = "../../../modules//helm-releases"
}

include "root" {
  path = find_in_parent_folders()
}

generate "provider-local" {
  path      = "provider-local.tf"
  if_exists = "overwrite"
  contents  = file("../../../provider-config/eks-addons/eks-addons.tf")
}

inputs = {
  helm_releases               = values.helm_releases
  eks_cluster_oidc_issuer_url = dependency.eks.outputs.cluster_oidc_issuer_url
  cluster_name                = "${values.env}-${values.project}"
}

dependency "eks" {
  config_path = values.eks_path

  mock_outputs = {
    cluster_oidc_issuer_url = "https://oidc.eks.eu-west-3.amazonaws.com/id/0000000000000000"
  }
}


skip = values.skip_module.helm_release