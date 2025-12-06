variable "cluster_name" {
  description = "ECSクラスター名"
  type        = string
}

variable "execution_role_arn" {
  description = "ECSタスク実行ロールARN"
  type        = string
}

variable "task_role_arn" {
  description = "ECSタスクロールARN"
  type        = string
}

variable "container_definition" {
  description = "ECSタスク定義設定マップ"
  type        = string
}

variable "vpc_id" {
  description = "ECSサービス用VPC ID"
  type        = string
}

variable "subnet_ids" {
  description = "ECSサービス用サブネットIDリスト"
  type        = list(string)
}
