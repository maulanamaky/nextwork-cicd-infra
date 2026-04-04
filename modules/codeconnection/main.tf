resource "aws_codeconnections_connection" "nextwork_connection" {
  name          = var.connection_name
  provider_type = var.provider_type
}
