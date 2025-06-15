ami_primary = "ami-0031a24a5d5c1edb7"
ami_secondary = "ami-001e8fc44ac03e5da"

primary_vpc_cidr      = "10.0.0.0/16"
secondary_vpc_cidr    = "10.1.0.0/16"

primary_subnet_cidr   = "10.0.1.0/24"
secondary_subnet_cidr = "10.1.1.0/24"

primary_instance_type = "t2.micro"
secondary_instance_type = "t2.micro"

sg_primary_id = "sg-0123456789abcdef0"

lambda_function_name = "FailoverLambda"

primary_region        = "eu-west-2"
secondary_region      = "eu-west-1"

primary_instance_id = "i-0123456789abcdef0"
secondary_instance_id = "i-0987654321abcdef0"