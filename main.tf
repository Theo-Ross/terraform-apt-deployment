provider "aws" {
    region="us-east-1"
}

# Create our VPC
resource "aws_vpc" "theoross-application-deployment" {
  cidr_block = "10.7.0.0/16"

  tags = {
    Name = "theoross-application-deployment-vpc"
  }
}

resource "aws_internet_gateway" "theoross-ig" {
    vpc_id = "${aws_vpc.theoross-application-deployment.id}"

    tags = {
        Name = "theoross-ig"
    }
}

resource "aws_route_table" "theoross-rt" {
    vpc_id = "${aws_vpc.theoross-application-deployment.id}"

    route {
        cidr_block = "0.0.0.0/0"
        gateway_id = "${aws_internet_gateway.theoross-ig.id}"
    }
  
}

module "application-tier" {
    name = "theoross-app"
    source = "./modules/application-tier"
    vpc_id = "${aws_vpc.theoross-application-deployment.id}"
    route_table_id = "${aws_route_table.theoross-rt.id}"
    cidr_block = "10.7.0.0/24"
    user_data=templatefile("./scripts/app_user_data.sh", {})
    ami_id = "ami-097ed995a6ede1d1b"
    
    map_public_ip_on_launch = true
    
    ingress = [
        { from_port = 80
        to_port = 80
        protocol = "tcp"
        cidr_blocks = "0.0.0.0/0"}
        ,{
        from_port = 22
        to_port = 22
        protocol = "tcp"
        cidr_blocks = "86.111.139.40/32"
    },{
        from_port = 22
        to_port = 22
        protocol = "tcp"
        cidr_blocks = "3.145.165.69/32"
    } ]
}


