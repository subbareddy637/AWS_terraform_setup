variable "subnet_cidr" {
    type = list(string)
}
variable "vpc_id" {
    type = string
}
variable "availability_zone" {
    type = list(string)
}
variable "map_public_ip_on_launch" {
    type = bool
}
variable "tags" {
  type = map(string)
}