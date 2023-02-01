variable "vpc_id" {
    description = "The VPC ID in AWS"
  
}

variable "name" {
    description = "Name to be used for the Tags"


}

variable "route_table_id" {
    description = "The Route Table ID in AWS"
  
}

variable "cidr_block" {
    description = "routing"
  
}

variable "ami_id" {
    description = "Theid id of the AMI for the instance"
}

variable "user_data" {
    description = "the User's data"
  
}

variable "map_public_ip_on_launch" {
    default = false
  
}

variable "ingress" {
    type = list
  
}


