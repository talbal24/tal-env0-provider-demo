terraform {
  required_providers {
    env0 = {
      source  = "env0/env0"
      version = "~> 1.0"
    }
  }
}

provider "env0" {
  # Credentials will be read from environment variables:
  # ENV0_API_KEY
  # ENV0_API_SECRET
}

# Variable for your project ID
variable "project_id" {
  description = "env0 Project ID"
  type        = string
}

# Environment: Created from VCS (without template)
resource "env0_environment" "vcs_environment" {
  name       = "my-vcs-environment"
  project_id = var.project_id
  workspace  = "my-vcs-workspace"
  
  without_template_settings {
    repository           = "https://github.com/talbal24/tal-gh-demo"
    type                 = "terraform"
    terraform_version    = "1.5.0"
    vcs_connection_id = "c0956ba9-012c-490e-a2bd-d97d97489a74"
  }
  
  # Optional VCS settings
  deploy_on_push                   = true
  run_plan_on_pull_requests        = true
  auto_deploy_on_path_changes_only = true
}

# Output to see the created environment ID
output "vcs_environment_id" {
  value       = env0_environment.vcs_environment.id
  description = "ID of the VCS-based environment"
}
