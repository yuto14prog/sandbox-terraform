variable "role_name" {
  description = "IAMロールの名前"
  type        = string
}

variable "assume_role_policy" {
  description = "IAMロールの信頼関係ポリシー(JSON形式)"
  type        = string
}

variable "managed_policy_arns" {
  description = "アタッチするAWSマネージドポリシーのARNリスト"
  type        = list(string)
  default     = []
}

variable "inline_policies" {
  description = "インラインポリシーのマップ(キー: ポリシー名、値: ポリシードキュメントJSON)"
  type        = map(string)
  default     = {}
}
