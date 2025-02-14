variable "vpc_config" {
    description = "to get the CIDR and Name of VPC from user"
    type = object({
      cidr_block = string
      name = string
    })

    validation {
      condition = can(cidrnetmask(var.vpc_config.cidr_block))
      error_message = "Invalid CIDR format - ${var.vpc_config.cidr_block}"
    }
  
}

variable "subnet_config" {
  #sub1=(cidr=.. az=..) sub2={}
  description = "get the CIDR and AZ for the subnets"
  type = map(object({
    cidr_block = string
    az = string
    public = optional(bool, false)
  }))
  validation {
    #sub1={cidr=..} sub2={cidr=..} [true, false,]
      condition = alltrue([for config in var.subnet_config : can(cidrnetmask(config.cidr_block))])
      error_message = "Invalid CIDR format" 
    }
} 
  