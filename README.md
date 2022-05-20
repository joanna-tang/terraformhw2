# terraformhw2
Modify your Homework 1 and create the following modules:

- VPC Module
- Launch configuration Module
- Autoscaling group Module

You must follow the standards that we covered during the classes.

Push everything to your Github Repo and send me the link.

# project description

The terraform project contains 3 modules, vpc, launchconfig, and autoscaling. 
It also uses a S3 backend for the state file.  

- The vpc module have 2 input variables, and 8 output variables 

| in:				| datatype	|
| --- | --- |
| prefix			| string	|
| ipblock			| string	|

|out:				| datatype	|
| --- | --- |
| vpc_id			| string	|
| prefix			| string	|
| privatesubnet1-3	| string	|
| publicsubnet1-3	| string	|

- The launchconfig module has 1 input (prefix) and 1 output (launch_config_name)

- The autoscaling module has 3 input and no output variables:

| in:					| datatype	|
| --- | --- |
| prefix				| string	|
| launch_config_name	| string	|
| subnet_ids			| list(string)|


To run this project, please make sure you have S3 / dynamoDB access. 
It might be necessary to change the backend section in resources.tf.
> terraform init
> 
> terraform apply

To remove all the changes, use this command:
> terraform destroy