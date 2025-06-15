provider "aws" {
  alias  = "primary"
  region = "eu-west-2"
}

provider "aws" {
  alias  = "secondary"
  region = "eu-west-1"
}
