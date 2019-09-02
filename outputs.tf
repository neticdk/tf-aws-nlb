/*
 * Copyright (c) 2019 Netic A/S. All rights reserved.
 *
 * This source code is licensed under the MIT license found in the
 * LICENSE file in the root directory of this source tree.
 */

output "lb_id" {
  description = "The ID of the load balancer"
  value       = aws_lb.this.id
}

output "lb_dns_name" {
  description = "The DNS name of the load balancer"
  value       = aws_lb.this.dns_name
}

output "target_group_arns" {
  description = "The arns of the target groups"
  value       = aws_lb_target_group.this.*.arn
}

output "listener_arns" {
  description = "The arns of the listeners"
  value       = aws_lb_listener.this.*.arn
}
