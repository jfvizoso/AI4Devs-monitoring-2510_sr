output "backend_instance_id" {
  description = "ID de la instancia EC2 backend"
  value       = aws_instance.backend.id
}

output "frontend_instance_id" {
  description = "ID de la instancia EC2 frontend"
  value       = aws_instance.frontend.id
}

output "datadog_dashboard_url" {
  description = "URL del dashboard de Datadog (EU1)"
  value       = "https://app.datadoghq.eu/dashboard/${datadog_dashboard.aws_infrastructure.id}"
}

output "datadog_aws_integration_role" {
  description = "Nombre del rol IAM usado por la integración AWS-Datadog"
  value       = aws_iam_role.datadog_aws_integration.name
}
