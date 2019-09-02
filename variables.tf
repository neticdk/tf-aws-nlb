/*
 * Copyright (c) 2019 Netic A/S. All rights reserved.
 *
 * This source code is licensed under the MIT license found in the
 * LICENSE file in the root directory of this source tree.
 */

variable "tags" {
  description = "A map of tags to add to all resources"
  default     = {}
}

variable "name" {
  description = "Load balancer name"
  type        = string
}

variable "vpc_id" {
  description = "ID of vpc to place load balancer in"
  type        = string
}

variable "subnet_ids" {
  description = "Subnet IDs to create load balancer in"
  type        = list
}

variable "internal" {
  description = "If true, the LB will be internal"
  type        = bool
  default     = false
}

variable "enable_deletion_protection" {
  description = "If true, deletion of the load balancer will be disabled via the AWS API"
  type        = bool
  default     = false
}

variable "enable_cross_zone_load_balancing" {
  description = "If true, cross-zone load balancing of the load balancer will be enabled"
  type        = bool
  default     = false
}

variable "idle_timeout" {
  description = "The time in seconds that the connection is allowed to be idle."
  type        = number
  default     = 60
}

variable "ip_address_type" {
  description = "The type of IP addresses used by the subnets for your load balancer. The possible values are ipv4 and dualstack."
  type        = string
  default     = "ipv4"
}

variable "target_groups" {
  description = "Subnet IDs to create load balancer in"
  type        = list(map(string))
  default     = []
}

variable "target_groups_defaults" {
  description = "Default values for target groups as defined by the list of maps."
  type = object(
    {
      cookie_duration                  = string,
      deregistration_delay             = string,
      health_check_healthy_threshold   = string,
      health_check_port                = string,
      health_check_unhealthy_threshold = string,
      target_type                      = string,
      slow_start                       = string,
    }
  )
  default = {
    cookie_duration                  = 86400
    deregistration_delay             = 300
    health_check_healthy_threshold   = 3
    health_check_port                = "traffic-port"
    health_check_unhealthy_threshold = 3
    target_type                      = "instance"
    slow_start                       = 0
  }
}

variable "listeners" {
  description = "A list of maps describing the listeners for this NLB"
  type        = list(map(string))
  default     = []
}
