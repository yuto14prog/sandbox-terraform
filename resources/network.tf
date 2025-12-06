module "ipv6" {
  source = "../modules/network"

  vpc_name = "ipv6-vpc"
  vpc_cidr = "10.1.0.0/16"

  public_subnets = {
    "public-0" = {
      cidr_block        = "10.1.0.0/24"
      availability_zone = "ap-northeast-1a"
      ipv6_index        = 0
    },
    "public-1" = {
      cidr_block        = "10.1.1.0/24"
      availability_zone = "ap-northeast-1c"
      ipv6_index        = 1
    }
  }

  private_subnets = {
    "private-0" = {
      cidr_block        = "10.1.10.0/24"
      availability_zone = "ap-northeast-1a"
      ipv6_index        = 2
    },
    "private-1" = {
      cidr_block        = "10.1.11.0/24"
      availability_zone = "ap-northeast-1c"
      ipv6_index        = 3
    }
  }
}
