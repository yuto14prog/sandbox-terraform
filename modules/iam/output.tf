output "role_arn" {
  description = "IAMロールのARN"
  value       = aws_iam_role.role.arn
}
