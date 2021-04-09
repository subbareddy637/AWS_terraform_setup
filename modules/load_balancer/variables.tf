variable "name" {
    type = string
}
variable "load_balancer_type" {
    type = string
}
variable "security_groups" {
    type = string
}
variable "subnets" {
    type = list(string)
}
variable "enable_deletion_protection" {
    type = bool
}
variable "load_balancer_arn" {
    type = string
}
variable "listener_port" {
    type = number
}
variable "target_group_arn" {
    type = string
}