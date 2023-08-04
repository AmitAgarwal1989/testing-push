
#############################################################################
#                 Local variables of SSL Certificates                       #
#############################################################################
data "aws_region" "current" {}
data "aws_caller_identity" "current" {}

locals {
  # Module name to be used for versioning
  tf_module_name = "accenture-cio/eip/aws"

  # Module version to be used for versioning
  tf_module_version = "0.0.1-alpha"

  # Label to be used for module semantic versioning

  tf_module_label = format("%s-%s", replace(local.tf_module_name, "/", "_"), replace(local.tf_module_version, ".", "_"))

  #split the role arn to get the role name
  deployer_role_name = split("/", data.aws_caller_identity.current.arn)
  split_role_name    = split("-", local.deployer_role_name[1])
  #extract environment code value from role name
  env_cd_val = local.split_role_name[1]
  #extract airid value from role name
  airid_val = local.split_role_name[0]

  //Environment short name mapping
  environment = local.env_tag_val[local.env_cd_val]
  env_tag_val = {
    "01"  = "prd"
    "b01" = "prd"
    "02"  = "npd"
    "b02" = "stg"
    "03"  = "sbx"
    "b03" = "dev"
  }

}

#############################################################################
#                 Creating the AWS Elastic IP                    #
#############################################################################

resource "aws_eip" "lb" {
  #domain   = "vpc"
  network_border_group = var.network_region
  tags = {
    airid       = local.airid_val
    environment = local.environment
    tf_mod      = local.tf_module_label
}
}