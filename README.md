# Netic NLB Module

## Supported Terraform Versions

Terraform 0.12

## Usage

```hcl
module "nlb" {
  source  = "github.com/neticdk/tf-aws-nlb"

  name               = "ssh-lb"
  vpc_id             = module.vpc.vpc_id
  subnets            = [module.vpc.private_subnets]

  target_groups = [
    {
      name = "ssh-target-group"
      backend_port = "22"
      backend_protocol = "TCP"
    }
  ]

  listeners = [
    {
      port = "22"
      protocol = "TCP"
    }
  ]
}
```

<!---BEGINNING OF PRE-COMMIT-TERRAFORM DOCS HOOK--->
## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|:----:|:-----:|:-----:|
| enable\_cross\_zone\_load\_balancing | If true, cross-zone load balancing of the load balancer will be enabled | bool | `"false"` | no |
| enable\_deletion\_protection | If true, deletion of the load balancer will be disabled via the AWS API | bool | `"false"` | no |
| idle\_timeout | The time in seconds that the connection is allowed to be idle. | number | `"60"` | no |
| internal | If true, the LB will be internal | bool | `"false"` | no |
| ip\_address\_type | The type of IP addresses used by the subnets for your load balancer. The possible values are ipv4 and dualstack. | string | `"ipv4"` | no |
| listeners | A list of maps describing the listeners for this NLB | list(map(string)) | `<list>` | no |
| name | Load balancer name | string | n/a | yes |
| protocol | Load balancer name | string | n/a | yes |
| subnet\_ids | Subnet IDs to create load balancer in | list | n/a | yes |
| tags | A map of tags to add to all resources | map | `<map>` | no |
| target\_groups | Subnet IDs to create load balancer in | list(map(string)) | `<list>` | no |
| target\_groups\_defaults | Default values for target groups as defined by the list of maps. | object | `<map>` | no |
| vpc\_id | ID of vpc to place load balancer in | string | n/a | yes |

## Outputs

| Name | Description |
|------|-------------|
| lb\_dns\_name | The DNS name of the load balancer |
| lb\_id | The ID of the load balancer |
| listener\_arns | The arns of the listeners |
| target\_group\_arns | The arns of the target groups |

<!---END OF PRE-COMMIT-TERRAFORM DOCS HOOK--->

# Copyright
Copyright (c) 2019 Netic A/S. All rights reserved.

# License
MIT Licened. See LICENSE for full details.

