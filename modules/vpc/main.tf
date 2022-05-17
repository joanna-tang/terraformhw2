
########################################################################
#  VPC
########################################################################
resource "aws_vpc" "main" {
  cidr_block = var.ipblock #"${var.ipblock}.0.0/16"
  tags = {
    Name = "${var.prefix}-vpc"
  }
}

########################################################################
#  Internet Gateway
########################################################################
resource "aws_internet_gateway" "igw" {
   vpc_id = aws_vpc.main.id
   tags = {
    Name = "${var.prefix}-internet-gateway"
   }
}

########################################################################
# 3 Public Subnets
########################################################################
resource "aws_subnet" "publicsubnet1" {
  vpc_id     = aws_vpc.main.id
  cidr_block = cidrsubnet(var.ipblock, 4, 1) #"${var.ipblock}.1.0/24"

  tags = {
    Name = "${var.prefix}-publicsubnet1"
  }
}

resource "aws_subnet" "publicsubnet2" {
  vpc_id     = aws_vpc.main.id
  cidr_block = cidrsubnet(var.ipblock, 4, 2)

  tags = {
    Name = "${var.prefix}-publicsubnet2"
  }
}
resource "aws_subnet" "publicsubnet3" {
  vpc_id     = aws_vpc.main.id
  cidr_block = cidrsubnet(var.ipblock, 4, 3)

  tags = {
    Name = "${var.prefix}-publicsubnet3"
  }
}

########################################################################
# 3 Private Subnets
########################################################################
resource "aws_subnet" "privatesubnet1" {
  vpc_id     = aws_vpc.main.id
  cidr_block = cidrsubnet(var.ipblock, 4, 4)

  tags = {
    Name = "${var.prefix}-privatesubnet1"
  }
}

resource "aws_subnet" "privatesubnet2" {
  vpc_id     = aws_vpc.main.id
  cidr_block = cidrsubnet(var.ipblock, 4, 5)

  tags = {
    Name = "${var.prefix}-privatesubnet2"
  }
}
resource "aws_subnet" "privatesubnet3" {
  vpc_id     = aws_vpc.main.id
  cidr_block = cidrsubnet(var.ipblock, 4, 6)

  tags = {
    Name = "${var.prefix}-privatesubnet3"
  }
}


########################################################################
# NAT Gateway
########################################################################
resource "aws_eip" "eip" {
  vpc = true
  tags = {
    Name = "${var.prefix}-eip"
  }
}
resource "aws_nat_gateway" "nat" {
  allocation_id = aws_eip.eip.id
  subnet_id     = aws_subnet.publicsubnet1.id

  tags = {
    Name = "${var.prefix}-nat-gateway"
  }

  # To ensure proper ordering, it is recommended to add an explicit dependency
  # on the Internet Gateway for the VPC.
  depends_on = [aws_internet_gateway.igw]
}

########################################################################
# 2 RouteTables (1 Public, 1 Private)
########################################################################
resource "aws_route_table" "publicrt" {
  vpc_id = aws_vpc.main.id

  route {
      cidr_block = "0.0.0.0/0"
      gateway_id = aws_internet_gateway.igw.id
  }
  tags = {
    Name = "${var.prefix}-public-routetable"
  }
}
resource "aws_route_table_association" "rtpublic1" {
  subnet_id      = aws_subnet.publicsubnet1.id
  route_table_id = aws_route_table.publicrt.id
}
resource "aws_route_table_association" "rtpublic2" {
  subnet_id      = aws_subnet.publicsubnet2.id
  route_table_id = aws_route_table.publicrt.id
}
resource "aws_route_table_association" "rtpublic3" {
  subnet_id      = aws_subnet.publicsubnet3.id
  route_table_id = aws_route_table.publicrt.id
}


resource "aws_route_table" "privatert" {
  vpc_id = aws_vpc.main.id

  route {
      cidr_block = "0.0.0.0/0"
      nat_gateway_id = aws_nat_gateway.nat.id
  }

  tags = {
    Name = "${var.prefix}-private-routetable"
  }
}
resource "aws_route_table_association" "rtprivate1" {
  subnet_id      = aws_subnet.privatesubnet1.id
  route_table_id = aws_route_table.privatert.id
}
resource "aws_route_table_association" "rtprivate2" {
  subnet_id      = aws_subnet.privatesubnet2.id
  route_table_id = aws_route_table.privatert.id
}
resource "aws_route_table_association" "rtprivate3" {
  subnet_id      = aws_subnet.privatesubnet3.id
  route_table_id = aws_route_table.privatert.id
}
