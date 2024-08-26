resource "aws_security_group" "harish_sg" {
  name   = "harish-sg"
  vpc_id = aws_vpc.harish_vpc.id

  dynamic "ingress" {
    for_each = var.ingress_ports
    iterator = ports
    content {
      from_port   = ports.value
      to_port     = ports.value
      protocol    = "tcp"
      cidr_blocks = ["0.0.0.0/0"]
    }

  }

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }
}

