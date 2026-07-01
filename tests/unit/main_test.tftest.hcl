# Unit Tests for tf-atom-iam-group-policy-attachment-aws
#
# These tests use a mock AWS provider — no real AWS calls are made.
# Run with:         terraform test -test-directory=tests/unit
# Run verbose:      terraform test -test-directory=tests/unit -verbose
# Run specific:     terraform test -test-directory=tests/unit -run "creates_when_enabled"

mock_provider "aws" {}

variables {
  # tf-label identity inputs
  namespace = "eg"
  stage     = "test"
  name      = "thing"

  # Module-specific required inputs
  group_name = "eg-test-developers"
  policy_arn = "arn:aws:iam::aws:policy/ReadOnlyAccess"
}

# ---------------------------------------------------------------------------
# Test: module attaches the policy when enabled
# ---------------------------------------------------------------------------
run "creates_when_enabled" {
  command = plan

  assert {
    condition     = output.enabled == true
    error_message = "enabled output should be true when the module is enabled"
  }

  assert {
    condition     = length(aws_iam_group_policy_attachment.this) == 1
    error_message = "exactly one aws_iam_group_policy_attachment resource should be planned when enabled"
  }

  assert {
    condition     = aws_iam_group_policy_attachment.this[0].group == "eg-test-developers"
    error_message = "the attachment should target the provided group_name"
  }

  assert {
    condition     = aws_iam_group_policy_attachment.this[0].policy_arn == "arn:aws:iam::aws:policy/ReadOnlyAccess"
    error_message = "the attachment should use the provided policy_arn"
  }
}

# ---------------------------------------------------------------------------
# Test: module creates nothing when disabled
# ---------------------------------------------------------------------------
run "disabled_creates_nothing" {
  command = plan

  variables {
    enabled = false
  }

  assert {
    condition     = output.enabled == false
    error_message = "enabled output should be false when the module is disabled"
  }

  assert {
    condition     = length(aws_iam_group_policy_attachment.this) == 0
    error_message = "no attachment resource should be planned when disabled"
  }

  assert {
    condition     = output.group == null
    error_message = "group output should be null when disabled"
  }

  assert {
    condition     = output.policy_arn == null
    error_message = "policy_arn output should be null when disabled"
  }
}
