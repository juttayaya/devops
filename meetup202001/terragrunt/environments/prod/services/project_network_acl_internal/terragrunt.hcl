include {
  path = find_in_parent_folders()
}

terraform {
  # Uncomment to use local filesystem terraform modules
  source = "../../../../../../../devops//meetup202001/terragrunt/modules/services/project_network_acl_internal"
  #source = "git::git@github.com:juttayaya/devops.git//meetup202001/terragrunt/modules/services/project_network_acl_internal?ref=v1.0.0"
}
