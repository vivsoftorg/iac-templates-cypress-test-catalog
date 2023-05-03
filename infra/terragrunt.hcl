locals {
  stack              = get_env("STACK_NAME", format("%.11s", basename(dirname(replace(get_parent_terragrunt_dir(), "infra", "")))))
  stack_name         = lower(replace(local.stack, "_", "-"))
  environment        = replace(path_relative_to_include(), "environments/", "")
  env_vars           = read_terragrunt_config(find_in_parent_folders("env.json", "env.json"), { inputs = {} })
  infra_vars           = read_terragrunt_config(find_in_parent_folders("tfvars.json", "tfvars.json"), { inputs = {} })
}


terraform {
  extra_arguments "common_vars" {
    commands = get_terraform_commands_that_need_vars()
  }
}

inputs = merge(
  local.infra_vars.inputs,
  local.env_vars.inputs,
  {
    environment                     = local.environment
    stack_name                      = local.stack_name
  }
)