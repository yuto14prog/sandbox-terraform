output "vpc_id" {
  description = "VPC ID"
  value       = aws_vpc.vpc.id
}

output "private_subnet_ids" {
  description = "Private Subnet IDs"
  value       = [for subnet in aws_subnet.private : subnet.id]
}
