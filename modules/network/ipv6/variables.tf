variable "vpc_name" {
  description = "VPC名"
  type        = string
}

variable "vpc_cidr" {
  description = "VPCのIPv4 CIDR範囲"
  type        = string
}

variable "public_subnets" {
  description = "public subnetのマップ（キー: サブネット名、値: cidr_block, availability_zone, ipv6_index）"
  type = map(object({
    cidr_block        = string
    availability_zone = string
    ipv6_index        = number
  }))
}

variable "private_subnets" {
  description = "プライベートサブネットのマップ（キー: サブネット名、値: cidr_block, availability_zone, ipv6_index）"
  type = map(object({
    cidr_block        = string
    availability_zone = string
    ipv6_index        = number
  }))
}
