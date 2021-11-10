/* Step 1: Define a provider
 * A provider alluws us to talk to specific API.
 * Downloading AWS provider ensures that Terraform dls all of the necessary code to talk to the AWS API, so that we can create resources within our AWS env.
 */

terraform {
  required_providers {
    aws = {
      source = "hashicorp/aws"
    }
  }
}


# Configure the AWS Provider
provider "aws" {
  region     = "ap-south-1"
  access_key = "" #use from config
  secret_key = "" #use from config
}

/* Step 2: Authentication - Add access-key and secret-key to provider as above
 */

/* Step 3: Create and Provision a resource.
 * Syntax: 
    resource "<providers>_<resource_type>" "name" {
        config options...
        key1 = "value1"
        key2 = "value2"
    }

 * the name is scoped to terraform and therfore, not visible at aws level
 */

# Deploying an ec2_instance:

# resource "aws_instance" "first_instance_tf" {
#   ami           = "ami-041db4a969fe3eb68"
#   instance_type = "t2.micro"

#   tags = {
#     Name = "TerraformInstance1"
#     # Description = "Trying Changes to instance with Terraform script. Addition of Description Tag."
#   }
# }

/* Step 4: Run the terraform script.
 * a. Do "terraform init"
        - This will search through all the terraform files and search for provider and download all the necessary plugins.

 * b. "terraform plan"
        - This will do a sort of dry run of the code so that we can see all the changes that will take place.

 * c. "terraform apply" - id=i-05b63ad0dae06d13c
        - This will actually run our code.

 * Re-running the same terraform script will not create another instance.
        - Unlike other programming languages terraform scripts are not carried out in a top to bottom manner, but rather in a declarative pattern.

        - It is the blueprint of what our entire infrastructure should look like.  

        - 1 block of ec2 resource means 1 instance - and that particular instance will remain irrespective of the number of times the code is run.

 * c. "terraform destroy"
        - This will show the changes that are going to be made.
        
        - Dark red ~ refers to the stuff that are going to be deleted.

        - Giving yes - removes the mentioned stuff from aws.

        - Immediately refreshing the console shows the instance in terminated state.

        - After around 2 hours, the terminated instance will get deleted.

        - That's the process to destroy an aws resource.

        - By default terraform destroy will destroy the entire infrastructure.

        - To avoid this, and to ensure destruction of a single resource, certain parameters must be provided to "terraform destroy" 
            => Commenting out the code of the non-reqd. resource and doing terraform apply will destroy that paricular resource.
            => Another great example of Terrraform's declarative style of programming.

 */


/* Creating VPC */

# resource "aws_subnet" "subnet1" {
#   vpc_id = aws_vpc.Terraform_VPC.id
#   # referencing resources that haven't been created yet 
#   #           => aws_<resource>.<resource name in terraform>.<property>
#   cidr_block = "10.0.1.0/24"

#   tags = {
#     Name = "prod_subnet"
#   }
# }

# order doesn't matter -vpc/subnet any can come first

# resource "aws_vpc" "Terraform_VPC" {
#   cidr_block = "10.0.0.0/16"

#   tags = {
#     Name = "production_vpc"
#   }
# }

/* Diles and directories:
 * Whenever we create any plugin, by doing "terraform init" 
       => .terraform folder gets created and it's going to install all the necessary plugins for our code

       => deleting this will result in provider error - try it on using "terraform apply"

       => do "terraform init" to re-install all the plugins.

 * terraform.tfstate => represents all of the states in terraform.

       => anytime we create a resource in aws, or any cloud provider, it keeps track of everything that is created.

       => reqd. to check the current status of the resource and update accordingly.

       => deleting this will result in mismatched state and will break terraform infrastructure

       => ******** NEVER MESS WITH *******
              "terraform.tfstate"
       **** MOST CRUCIAL FILE FOR TERRAFORM ****
 */

# resource "aws_vpc" "Terraform_VPC2" {
#   cidr_block = "10.1.0.0/16"

#   tags = {
#     Name = "dev_vpc"
#   }
# }

# resource "aws_subnet" "subnet2" {
#   vpc_id = aws_vpc.Terraform_VPC2.id

#   cidr_block = "10.1.1.0/24"

#   tags = {
#     Name = "dev_subnet"
#   }
# }
