include {
  path = find_in_parent_folders()
}

terraform {
  # Uncomment to use local filesystem terraform modules
  source = "../../../../../../../devops//meetup202001/terragrunt/modules/services/project_vpc"
  #source = "git::git@github.com:juttayaya/devops.git//meetup202001/terragrunt/modules/services/project_vpc?ref=v1.0.0"
}

inputs = {
  cidr_block_host_octets = "172.30"
}