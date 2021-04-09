variable "name" {
  type = string
}
variable "ami" {
  type = string
}
variable "instance_type" {
  type = string
}
variable "security_group_id" {
  type = string
}
variable "associate_public_ip_address" {
  type = bool
}
variable "key_name" {
  type = string
}
variable "device_name" {
  type = string
}
variable "volume_type" {
  type = string
}
variable "volume_size" {
  type = number
}
variable "volume_iops" {
  type = number
}



variable "asg_name" {
  type = string
}
variable "max_size" {
  type = number
}
variable "min_size" {
  type = number
}
variable "health_check_type" {
  type = string
}
variable "desired_capacity" {
  type = number
}
variable "subnet_ids" {
  type = list(string)
}
variable "target_group_arns" {
  type = string
}
variable "tags" {
  type = map(string)
}

