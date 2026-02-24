variable "aws_region" {
  description = "Región AWS"
  type        = string
  default     = "us-east-1"
}

# Las claves se inyectan mediante variables de entorno: TF_VAR_datadog_api_key y TF_VAR_datadog_app_key
variable "datadog_api_key" {
  description = "API Key de Datadog (usar TF_VAR_datadog_api_key)"
  type        = string
  sensitive   = true
}

variable "datadog_app_key" {
  description = "Application Key de Datadog (usar TF_VAR_datadog_app_key)"
  type        = string
  sensitive   = true
}
