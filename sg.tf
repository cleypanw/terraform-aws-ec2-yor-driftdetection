#########
# Security group configuration

resource "aws_security_group" "sg-ec2" {

  description = "SG for ec2-instance"
  name        = local.sg_name
  vpc_id      = aws_vpc.my_vpc.id

  ingress {
    description = "ssh access"
    from_port   = 22
    to_port     = 22
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  egress {
    description = "Allow outbound access"
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }
  tags = {
    yor_name  = "sg-ec2"
    yor_trace = "beb0f606-6f57-4b39-aeed-a0a680fa7b50"
  }
}