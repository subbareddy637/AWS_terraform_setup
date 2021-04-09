variable "name" {
  type = string
}
variable "vpc_id" {
  type = string
}
variable "target_group_port" {
  type = number
}
variable "health_check_port" {
  type = number
}
variable "tags" {
  type = map(string)
}