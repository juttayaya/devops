include {
  path = find_in_parent_folders()
}

terraform {
  # Uncomment to use local filesystem terraform modules
  source = "../../../../../../../devops//meetup202001/terragrunt/modules/services/project_security_groups"
  #source = "git::git@github.com:juttayaya/devops.git//meetup202001/terragrunt/modules/services/project_security_groups?ref=v1.0.0"
}
