#provider variable#

variable "region" {
  default     = "eu-west-2"
  description = "aws region"
}

#vpc variable#

variable "vpc_cidr" {
  default     = "10.0.0.0/16"
  description = "vpc cidr block"
}

#subnet variable#

variable "prod_pubsub_1_cidr" {
  default     = "10.0.1.0/24"
  description = "prod pubsub 1 cidr"
}

variable "prod_pubsub_2_cidr" {
  default     = "10.0.2.0/24"
  description = "prod pubsub 2 cidr"
}

variable "prod_ptesub_1_cidr" {
  default     = "10.0.3.0/24"
  description = "prod ptesub 1 cidr"
}

variable "prod_ptesub_2_cidr" {
  default     = "10.0.4.0/24"
  description = "prod ptesub 2 cidr"
}

# variable rt#

variable "route_table_id" {
  default     = "prod_pub_rt,prod_pte_rt"
  description = "aws route tables"
}


# variable for internet gateway

variable "internet_gateway" {
  default     = "prod_IGW"
  description = "aws internet gateway"
}

# variable for IGW route #

variable "pub_IGW_route_cidr" {
  default     = "0.0.0.0/0"
  description = "aws IGW routing"
}

# var for NAT gw #

variable "nat_gateway" {
  default     = "prod_nat_gateway"
  description = "provisioning of NGW"
}

# var nat gateway route to pte #
variable "pte_nat_gateway_route_cidr" {
    default = "0.0.0.0/0"
    description = "pte NAT gateway provision"
}