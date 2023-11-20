security_groups = {
  "cloud_2021_sg" : {
    description = "Security group for web servers"
    ingress_rules = [
      {
        description = "ingress rule for http"
        priority    = 200
        from_port   = 80
        to_port     = 80
        protocol    = "tcp"
        cidr_blocks = ["192.168.1.1/32"]
      },
      {
        description = "my_ssh"
        priority    = 202
        from_port   = 22
        to_port     = 22
        protocol    = "tcp"
        cidr_blocks = ["192.168.1.1/32"]
      },
      {
        description = "ingress rule for http"
        priority    = 204
        from_port   = 443
        to_port     = 443
        protocol    = "tcp"
        cidr_blocks = ["192.168.1.1/32"]
      }
    ]
    egress_rules = [
      {
        priority    = 502
        from_port   = 8000
        to_port     = 8000
        protocol    = "tcp"
        cidr_blocks = ["192.168.1.1/32"]
      },
      {
        priority    = 504
        from_port   = 8080
        to_port     = 8080
        protocol    = "tcp"
        cidr_blocks = ["192.168.1.1/32"]
      },
      {
        priority    = 506
        from_port   = 8888
        to_port     = 8888
        protocol    = "tcp"
        cidr_blocks = ["192.168.1.1/32"]
      },
    ]
  }
}