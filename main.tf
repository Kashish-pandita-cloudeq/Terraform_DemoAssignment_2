resource "aws_instance" "web" {
  count         = length(var.instance_name)  #runs and make instance according to the number of inputs provided in the instance_name in tfvars with index starting with 0
  ami           = "ami-0cff7528ff583bf9a"
  instance_type = "t2.micro"
  #count = 4   //makes instance on the basis of the number provided here
  #count         = var.cnt  //makes number of resources on the basis of the of the number of instance name provided in the tfvars

  tags = {
    #Name = "Demo-instance-terraform-kashish${count.index}", //same name with different count
    #Name = var.ins_name[0] //will give same name for all the instance in list in tfvars file
    Name  = var.instance_name[count.index],     //will give different names for all the different resources from the list
    
Owner = "Kashish"
  }
}

terraform {
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "4.23.0"
    }
  }
}

#for_each loop works for map and set only
#count is index based whereas for_each loop works on key or value given in the set or list
#map stores in the form of key value pair map{"key="value}

resource "aws_instance" "My_new_instance" {
  for_each      = var.loop_name
  ami           = "ami-0cff7528ff583bf9a"
  instance_type = "t2.micro"

   tags   = {
    Name  = each.value,     
    Owner = each.key
  }
}

resource "aws_instance" "My_another_instance" {
  for_each      = var.new_loop
  ami           = each.value.ami
  instance_type = each.value.instance_type

   tags   = {
    Name  = each.value.name,     
    Owner = each.key
  }
}


