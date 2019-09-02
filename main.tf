/*
 * Copyright (c) 2019 Netic A/S. All rights reserved.
 *
 * This source code is licensed under the MIT license found in the
 * LICENSE file in the root directory of this source tree.
 */

locals {
  tags = {
    Terraform = "true"
  }

  all_tags = merge(var.tags, local.tags)
}

resource "aws_lb" "this" {
  load_balancer_type               = "network"
  name                             = var.name
  internal                         = var.internal
  idle_timeout                     = var.idle_timeout
  subnets                          = var.subnet_ids
  enable_deletion_protection       = var.enable_deletion_protection
  enable_cross_zone_load_balancing = var.enable_cross_zone_load_balancing
  ip_address_type                  = var.ip_address_type


  tags = merge(
    {
      Name = var.name
    },
    local.all_tags,
  )
}

resource "aws_lb_target_group" "this" {
  count = length(var.target_groups)

  name     = var.target_groups[count.index]["name"]
  vpc_id   = var.vpc_id
  port     = var.target_groups[count.index]["backend_port"]
  protocol = upper(var.target_groups[count.index]["backend_protocol"])

  deregistration_delay = lookup(
    var.target_groups[count.index],
    "deregistration_delay",
    var.target_groups_defaults["deregistration_delay"],
  )

  target_type = lookup(
    var.target_groups[count.index],
    "target_type",
    var.target_groups_defaults["target_type"],
  )

  slow_start = lookup(
    var.target_groups[count.index],
    "slow_start",
    var.target_groups_defaults["slow_start"],
  )

  health_check {
    interval = lookup(
      var.target_groups[count.index],
      "health_check_interval",
      var.target_groups_defaults["health_check_interval"],
    )
    port = lookup(
      var.target_groups[count.index],
      "health_check_port",
      var.target_groups_defaults["health_check_port"],
    )
    healthy_threshold = lookup(
      var.target_groups[count.index],
      "health_check_healthy_threshold",
      var.target_groups_defaults["health_check_healthy_threshold"],
    )
    unhealthy_threshold = lookup(
      var.target_groups[count.index],
      "health_check_unhealthy_threshold",
      var.target_groups_defaults["health_check_unhealthy_threshold"],
    )
    timeout = lookup(
      var.target_groups[count.index],
      "health_check_timeout",
      var.target_groups_defaults["health_check_timeout"],
    )
    protocol = upper(
      lookup(
        var.target_groups[count.index],
        "healthcheck_protocol",
        var.target_groups[count.index]["backend_protocol"],
      ),
    )
  }

  tags = merge(
    {
      Name = var.target_groups[count.index]["name"]
    },
    local.all_tags,
  )

  depends_on = [aws_lb.this]

  lifecycle {
    create_before_destroy = true
  }
}

resource "aws_lb_listener" "this" {
  count = length(var.http_tcp_listeners)

  load_balancer_arn = aws_lb.this.arn
  port              = var.http_tcp_listeners[count.index]["port"]
  protocol          = upper(var.http_tcp_listeners[count.index]["protocol"])

  default_action {
    target_group_arn = aws_lb_target_group.this[lookup(var.http_tcp_listeners[count.index], "target_group_index", 0)].id
    type             = "forward"
  }
}
