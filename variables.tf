variable "group_name" {
  description = "Name of the IAM group to attach the policy to"
  type        = string
  validation {
    condition     = length(var.group_name) > 0
    error_message = "group_name must not be empty."
  }
}

variable "policy_arn" {
  description = "ARN of the IAM policy to attach"
  type        = string
  validation {
    condition     = can(regex("^arn:aws:iam::", var.policy_arn))
    error_message = "policy_arn must be a valid IAM policy ARN."
  }
}
