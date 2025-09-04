# GPC VM Submodule

This module will build a VPC network and VM instance in Google Cloud Platform (GPC). It provisions that instance with a bash script and env vars that you feed it. This module intends to help you focus on what you want to run in a GCP VM without having to think much about how to create one.

## Variables

To use this module, you need to add the following required variables:

1. `test_env_name` : string, give your test environment a unique name
2. `creator` : string, identify yourself. This ends up in a bunch of tags on things so that people in your org can know who built the environemnt.
3. `gpc_project` : string, the GCP project id in which you wish to create these resources.
4. `gcp_region` : string, the region you want to work in, e.g, "us-central1".
5. `gcp_zone` : string, the zone you want to work in, e.g, "us-central1-c".
6. `network_name` : string, the name you want to give to the network you'll create.
7. `access_ips` : []string, add a list of IPs you want to be able to ssh to your instance from. You'll need this to successfully provision and connect to your instance.

You can optionally add of these extra variables too:

1. `instance_cnt` : integer, defaults to "1" but you can set it to "0" if you want to destroy your VM instance without having to really destroy everything. Useful for re-testing your provisioning script.
2. `extra_security_group_ids` : []string, a list of security group IDs for any existing security groups you want to associate your instance to.
3. `instance_type` : string, the type of your VM instance. Defaults to `e2-micro`.
4. `instance_image` : string, the OS boot image of your VM instance. Defaults to an ubuntu 24.04 image.
5. `instance_global_vars` : map(any), a key-value pair of global environment variables that will be created in your instance upon provisioning. Alternative to using a `setup.env` (described below) which only makes environment variables available for the provisioning shell session. You can use both this and `setup.env` at the same time.
6. `user` : string, the username of your user for provising and interacting with your user. defaults to "ubuntu"
7. `instance_home` : string, the home of your instance user
8. `setup_path` : string, the path to the directory that will contain your setup.sh and `./data/` directory (probably don't need to set this)
9. `extra_ingress_rules` : map(any), a dict of custom ingress rules to apply to your firewalls for accessing custom ports. E.g, `{"postgresql": {"port": "5432", "protocol": "tcp"}}`

## How to use this module

Any time you use this module, you need to follow a few rules. Specifically your working directory must contain...

1. a `setup.sh` bash file that will be used to provision your instance. E.g, if you want your instance to run nginx, write this script to install nginx. Writing this file is where the bulk of your time setting up an instance will be spent.
2. a `setup.env` file to contain `VAR="value"` strings, which gets planted in the home directory of your instance. Your `setup.sh` would generally source that file to create the local environment variables you want available at the time of provisioning.
3. a `data/` directory to contain any other files you want available to your `setup.sh` script at the time of provisioning. This directory and all its contents get copied to the home directory of your instance, so your `setup.sh` can find them at `${HOME}/data/`.

## Accessing your instance after it is provisioned

This module includes an `output` called `ssh_connection_command` that will give you the ssh command you'll need to make to connect to your instance. It's recommended to pass that output to your root module so that you can run a `terraform show` to remind yourself how to connect to your instance. It is marked as "sensitive", so you will need to mark your own calling module's output as "sensitive" as well, and you'll need to explicitly specify that output in your `show` command to see it, e.g, `terraform show ssh_connection_command`.

## Usage

Once you've set it all up, spinning up your instnace is pretty simple:

```
terraform init
terraform plan
terraform apply
```

The entrypoint output, if you configured it, will show you how to connect to your instance, and you can run `terraform show` to find it again if ever you need.
