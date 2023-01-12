
# EC2 Submodule

This module will build an ec2 instance and provision it with a bash script and env vars that you feed it. It lets you focus more on what you want to run in an ec2 instance without having to think about how to create one.

## Variables

To use this module, you need to add the following required variables:

1. `test_env_name` : string, give your test environment a unique name
2. `creator` : string, identify yourself. This ends up in a bunch of tags on things so that people in your org can know who built the environemnt.
3. `profile` : string, the AWS profile you're using to authenticate with your AWS account. 
4. `credentials_file` : string, the path and file you want to use to authenticate with aws. Defaults to `~/.aws/credentials`
5. `aws_region` : string, the region you want to work in, e.g, "us-east-1".
6. `vpc_id` : string, the ID for the VPC you want to work in.
7. `subnet_id` : string, the ID for the subnet you want to work in. 
8. `access_ips` : []string, add a list of IPs you want to be able to ssh to your instance from. You'll need this 

You can optionally add of these extra variables too:

1. `instance_cnt` : integer, defaults to "1" but you can set it to "0" if you want to destroy your EC2 instance without having to really destroy everything. Useful for re-testing your provisioning script. 
2. `extra_security_group_ids` : []string, a list of security group IDs for any existing security groups you want to associate your instance to. 
3. `cidr_blocks` : []string, a list of your VPC's cidr blocks that you want to work in. Defaults to `["10.0.0.0/16"]`
4. `instance_type` : string, the type.size of your ec2 instance. Defaults to `t2.micro`. 
5. `instance_global_vars` : map(any), a key-value pair of global environment variables that will be created in your instance upon provisioning. Alternative to using a `setup.env` (described below) which only makes environment variables available for the provisioning shell session. You can use both this and `setup.env` at the same time.

Here's some variables that you could overwrite if you want to, but it's not recommended unless you're doing some fancy stuff. 

1. `user` : string, the OS user to work with on your instance
2. `ami` : string, the AMI for your ec2 instance. Defualts to a standard AWS-supported one for Ubuntu 20.04
3. `instance_home` : string, the home path of your instance. 
4. `setup_path` : string, a custom path to the directory that contains your provisioning assets (`setup.sh`, `setup.env`, and `data/*`)

## How to use this module

Any time you use this module, you need to follow a few rules. Specifically your working directory must contain...

1. a `setup.sh` bash file that will be used to provision your instance. E.g, if you want your instance to run nginx, write this script to install nginx. Writing this file is where the bulk of your time setting up an instance will be spent. 
2. a `setup.env` file to contain `VAR="value"` strings, which gets planted in the home directory of your instance. Your `setup.sh` would generally source that file to create the local environment variables you want available at the time of provisioning. 
3. a `data/` directory to contain any other files you want available to your `setup.sh` script at the time of provisioning. This directory and all its contents get copied to the home directory of your instance, so your `setup.sh` can find them at `${HOME}/data/`. 

## Accessing your instance after it is provisioned

This module includes an `output` called `entrypoint` that will give you the ssh command you'll need to make to connect to your instance. It's recommended to pass that output to your root module so that you can run a `terraform show` to remind yourself how to connect to your instance. 

## Usage

Once you've set it all up, spinning up your instnace is pretty simple:

```
terraform init
terraform plan
terraform apply
```

The entrypoint output, if you configured it, will show you how to connect to your instance, and you can run `terraform show` to find it again if ever you need. 
