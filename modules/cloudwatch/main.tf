resource "aws_cloudwatch_log_group" "nextwork_log_group" {
  name = var.group_name
}

resource "aws_cloudwatch_log_stream" "nextwork_log_stream" {
  name           = var.stream_name
  log_group_name = aws_cloudwatch_log_group.nextwork_log_group.name
}