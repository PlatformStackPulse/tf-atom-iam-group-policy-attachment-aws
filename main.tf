# -----------------------------------------------------
# Atom: IAM Group Policy Attachment
# Attaches a managed policy to an IAM group.
# -----------------------------------------------------
resource "aws_iam_group_policy_attachment" "this" {
  count = module.this.enabled ? 1 : 0

  group      = var.group_name
  policy_arn = var.policy_arn
}
