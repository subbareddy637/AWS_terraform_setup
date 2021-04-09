variable "name" {
    type = string
}
variable "description" {
    type = string
}
variable "vpc_id" {
    type = string
}
variable "sg_ingress" {
    type = list(any)
}
variable "sg_egress" {
    type = list(any)
}

