resource "aws_vpc" "my_vpc" {
  cidr_block           = "10.0.0.0/16"
  instance_tenancy     = "default"
  enable_dns_hostnames = true

  tags = {
    Name      = local.vpc_name
    yor_name  = "my_vpc"
    yor_trace = "5c478064-f9a0-4769-b2b3-2971bb43ab73"
  }
}

resource "aws_subnet" "public" {
  vpc_id                  = "${aws_vpc.my_vpc.id}"
  cidr_block              = "10.0.4.0/24"
  availability_zone       = data.aws_availability_zones.available.names[0]
  map_public_ip_on_launch = "true"

  tags = {
    Name      = local.public_subnet_name
    yor_name  = "public"
    yor_trace = "27c742f4-f6e0-4b50-95f2-528870f1e667"
  }
}

resource "aws_subnet" "private" {
  vpc_id            = "${aws_vpc.my_vpc.id}"
  cidr_block        = "10.0.1.0/24"
  availability_zone = data.aws_availability_zones.available.names[1]

  tags = {
    Name      = local.private_subnet_name
    yor_name  = "private"
    yor_trace = "3f1129cc-a23d-4703-8827-7d239ce2d081"
  }
}

resource "aws_internet_gateway" "gw" {
  vpc_id = aws_vpc.my_vpc.id

  tags = {
    Name      = local.igw_name
    yor_name  = "gw"
    yor_trace = "5674cd10-aad2-4b40-b85b-8969533078e7"
  }
}

resource "aws_route_table" "second_rt" {
  vpc_id = aws_vpc.my_vpc.id
  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = aws_internet_gateway.gw.id
  }

  tags = {
    Name      = local.rt_name
    yor_name  = "second_rt"
    yor_trace = "44912919-f2ed-41a7-a823-5f4711fddd16"
  }
}

resource "aws_route_table_association" "public_subnet_asso" {
  subnet_id      = aws_subnet.public.id
  route_table_id = aws_route_table.second_rt.id
}