variable "vpc_id" {
    type = string
}
variable "igw_id" {
    type = string
    default = ""
}
variable "public_rt_name" {
  type = string
}
variable "nat_gateway_id" {
    type = string
}
variable "subnet_cidr" {
    type = list(string)
}
variable "subnets" {
    type = list(string)
}
variable "private_rt_name" {
  type = string
}
variable "public_route_table" {
  type = bool
}