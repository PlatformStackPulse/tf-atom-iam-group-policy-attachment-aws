output "enabled" {
  description = "Whether the module is enabled"
  value       = local.enabled
}

output "group" {
  description = "Name of the group the policy is attached to"
  value       = try(aws_iam_group_policy_attachment.this[0].group, null)
}

output "policy_arn" {
  description = "ARN of the attached policy"
  value       = try(aws_iam_group_policy_attachment.this[0].policy_arn, null)
}
