# Create Grafana security group
resource "aws_security_group" "grafana_sg"{
  name = "Grafana SG"
  description = "Allow ports 3000 and 22"
  vpc_id = aws_vpc.production_vpc.id

  ingress {
    description = "Grafana"
    from_port = var.grafana_port
    to_port = var.grafana_port
    protocol = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  ingress {
    description = "SSH"
    from_port = var.ssh_port
    to_port = var.ssh_port
    protocol = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  egress {
    from_port = 0
    to_port = 0
    protocol = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }

  tags = {
    Name = "Grafana SG"
  }
}



resource "aws_instance" "Grafana"{
    ami = var.ec2_ami
    instance_type = var.micro_instance
    availability_zone = var.availability_zone
    subnet_id = aws_subnet.public_subnet.subnet_id
    key_name = var.key_name
    vpc_security_group_ids = [aws_security_group.grafana_sg.id]

}