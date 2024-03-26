output "grafana_public_ip"{
    description = "Public IP of the Grafana instance"
    value = aws_instance.Grafana_ip
}