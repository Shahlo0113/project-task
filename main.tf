resource "aws_eip" "cloud_2021" {
  instance = aws_instance.cloud_2021.id
  domain   = "vpc"
  depends_on                = [aws_internet_gateway.gw]
}

output "public_ip" {
  value = aws_instance.cloud_2021.public_ip
}

resource "aws_security_group" "cloud_2021" {
  for_each = var.security_groups

  name        = each.key
  description = each.value.description
  vpc_id      = aws_vpc.main.id

  dynamic "ingress" {
    for_each = each.value.ingress_rules != null ? each.value.ingress_rules : []

    content {
      description = ingress.value.description
      from_port   = ingress.value.from_port
      to_port     = ingress.value.to_port
      protocol    = ingress.value.protocol
      cidr_blocks = ingress.value.cidr_blocks
    }
  }

  dynamic "egress" {
    for_each = each.value.egress_rules != null ? each.value.egress_rules : []


    content {
      description = egress.value.description
      from_port   = egress.value.from_port
      to_port     = egress.value.to_port
      protocol    = egress.value.protocol
      cidr_blocks = egress.value.cidr_blocks
    }
  }
}

resource "aws_instance" "cloud_2021" {

  ami           = var.ami["us-east-1"]
  instance_type = var.instance_types[0]
  key_name      = var.key_name
  subnet_id              = aws_subnet.main.id
  #vpc_security_group_ids = [module.security_groups.security_group_id["cloud_2023_sg"]] 
  vpc_security_group_ids = [aws_security_group.default["cloud_2023_sg"].id ]
  tags = {
    Name = "cloud_2021"
  }
  }

  resource "aws_vpc" "main" {
  cidr_block = "10.0.0.0/16"
 
  tags = {
    Name = "cloud_2021"
  }
}

resource "aws_subnet" "main" {
  vpc_id     = aws_vpc.main.id
  cidr_block = "10.0.1.0/24"
 
  map_public_ip_on_launch = true # To ensure the instance gets a public IP
 
  tags = {
    Name = "cloud_2021"
  }
}
