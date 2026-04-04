output "group_name" {
    value = aws_cloudwatch_log_group.nextwork_log_group.name
}

output "stream_name" {
    value = aws_cloudwatch_log_stream.nextwork_log_stream.name
}

output "log_group_arn" {
    value = aws_cloudwatch_log_group.nextwork_log_group.arn
}