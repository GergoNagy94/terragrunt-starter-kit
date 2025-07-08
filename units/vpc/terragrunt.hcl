terraform {
  source = "git::https://github.com/terraform-aws-modules/terraform-aws-vpc.git?ref=v6.0.1"

}

include "root" {
  path = find_in_parent_folders("root.hcl")
}

inputs = {
  cidr            = values.locals.vpc_cidr
  azs             = values.locals.availability_zone
  private_subnets = [for k, v in values.locals.availability_zone : cidrsubnet(values.locals.vpc_cidr, 4, k)]
  public_subnets  = [for k, v in values.locals.availability_zone : cidrsubnet(values.locals.vpc_cidr, 8, k + 48)]

  create_egress_only_igw = values.locals.vpc_create_egress_only_igw
  enable_dns_hostnames   = values.locals.vpc_enable_dns_hostnames
  enable_dns_support     = values.locals.vpc_enable_dns_support
  enable_nat_gateway     = values.locals.vpc_nat_gateway
  single_nat_gateway     = values.locals.vpc_single_nat_gateway

  private_route_table_tags = { Name = "${values.locals.env}-private" }
  private_subnet_tags = {
    "Name"                                                                         = "${values.locals.env}-private"
    "kubernetes.io/role/internal-elb"                                              = 1
    "kubernetes.io/cluster/${values.locals.env}-${values.locals.eks_cluster_name}" = "owned"
  }

  public_route_table_tags = { Name = "${values.locals.env}-public" }
  public_subnet_tags = {
    "Name"                                                                         = "${values.locals.env}-public"
    "kubernetes.io/role/elb"                                                       = 1
    "kubernetes.io/cluster/${values.locals.env}-${values.locals.eks_cluster_name}" = "owned"
  }

  tags = values.locals.tags
}

skip = values.locals.skip_module.vpc