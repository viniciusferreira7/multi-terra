variable "state_bucket" {
  type        = string
  default     = ""
  description = "State of bucket"
}

variable "profile" {
  description = "AWS profile configured in CLI"
  type        = string
  default     = ""
}