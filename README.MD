![AyeAye](https://github.com/devops-recipes/provision-aws-ansible/blob/master/public/resources/images/captain.png)

# Infrastructure provisioning on AWS with Ansible and Terraform within a Shippable workflow
A Shippable workflow for provisioning and terminating:
  * AWS EC/2 instances with associated resources using Terraform
  * AWS ECS cluster with containers instances using Ansible

This repo demonstrates the following features:
* Set up CD workflow jobs to:
  * Provision and terminate AWS instances using Terraform 
  * Provision and terminate an Amazon ECS cluster with container instances
* Use of Ansible:
  * Create an ECS cluster
  * Provision EC/2 container instances
  * Store AWS resource info in Shippable's central state for use in later jobs
  * Terminate and delete all running ECS
  * Terminate EC/2 container instances
  * Delete an ECS cluster
* Use of Terraform:
  * Provision EC/2 container instances
  * Store AWS resource info in Shippable's central state for use in later jobs
  * Terminate EC/2 container instances
* Use of `runSh` jobs in a Shippable workflow
* Use of the `PEM Key` Account Integration in a Shippable workflow job

## Prerequisites to run this sample
* Source control account (e.g. GitHub, Bitbucket, Gitlab)
* Shippable account (sign up for free at www.shippable.com)
* Amazon Web Services account (aws.amazon.com)

NOTE: 
This sample is part of a larger workflow configured in five separate repositories 
found at http://github.com/aye0aye. It is intended to be used with other jobs and 
resources also loaded into the SPOG view from those other repos. To run this 
without those, remove any `IN:` or `OUT:` values in the shippable.job.yml file 
found in this repo that refer to jobs or resources not defined in this repo.

## Setup
* Fork this repo to your source control account
* Follow the [instructions](insert link) to store your AWS credentials needed 
for this sample in Shippable
* All workflow config is in `shippable.resources.yml` and `shippable.jobs.yml`. 
Check these files and update config wherever the comment asks you to replace 
with your specific values (for example, to replace with your Integration names)
* Specifications for the instances that will be launched in AWS can be found in 
group_vars/ecs-cluster-vars.yml and awsProdECS/variables.tf. Update these, as 
appropriate.
* Add the workflow to your SPOG view in Shippable:
  * Select your subscription from the dropdown menu in the left nav
  * Select the "+" icon in the upper right
  * Select the source control repo where your fork is, in the 'Add a Sync 
  Repository' section
* After processing completes, you should see the new jobs and resources now added 
to your Single Pane of Glass view

## Run the workflow 
* Right-click on the runSh job in the SPOG view named 'prov_ecs_prod' and run the job.
This will execute a set of Terraform scripts.
  * This demo uses a custom scripting job type called 'runSh' in Shippable - 
  [learn more about 'runSh' jobs](http://docs.shippable.com/workflows/jobs/runSh/) 
* When your job completes, you should see new EC/2 instances in your AWS account. 
* Right-click on the runSh job named 'prov_ecs_test' and run the job. This will
execute an Ansible playbook.
* When your job completes, you should see an ECS cluster and related container 
instances in your AWS account.
* At any time, right-click and run the `de_prov_ecs_test` or `de_prov_ecs_prod` 
jobs to terminate those environments using Ansible and Terraform.
* When the jobs complete, you should now see all of the instances terminated in
EC/2 and the ECS clusters terminated.

With this approach, your entire team can easily manage infrastructure 
provisioning as a dedicated workflow or incorporate on-demand provisioning as 
a step in an end-to-end testing scenario.

Additional notes:
* This sample uses [dynamic inventory](http://docs.ansible.com/ansible/intro_dynamic_inventory.html#example-aws-ec2-external-inventory-script). 
You can also use static inventory by updating the inventory/static_hosts file. 
To turn off dynamic inventory, comment out the config in inventory/base.


# Kubernetes cluster provisioning on AWS with KOPS within a Shippable workflow
A Shippable workflow for provisioning and terminating:
  * A Kubernetes cluster and all associated resources on AWS

This repo demonstrates the following features:
* Set up CD workflow jobs to:
  * Provision and terminate a Kubernetes cluster using KOPS
* Use of `runSh` jobs in a Shippable workflow

## Prerequisites to run this sample
* Source control account (e.g. GitHub, Bitbucket, Gitlab)
* Shippable account (sign up for free at www.shippable.com)
* Amazon Web Services account (aws.amazon.com)

NOTE: 
This sample is part of a larger workflow configured in multiple repositories 
found at http://github.com/aye0aye. It is intended to be used with other jobs and 
resources also loaded into the SPOG view from those other repos. To run this 
without those, remove any `IN:` or `OUT:` values in the shippable.job.yml file 
found in this repo that refer to jobs or resources not defined in this repo.

## Setup
* Fork this repo to your source control account
* Follow the [instructions](insert link) to store your AWS credentials needed 
for this sample in Shippable
* All workflow config is in `shippable.resources.yml` and `shippable.jobs.yml`. 
Check these files and update config wherever the comment asks you to replace 
with your specific values (for example, to replace with your Integration names)
* Specifications for the instances that will be launched in AWS can be found in 
shippable.resources.yml under the resource named `kube_cluster_config`. Update 
these, as appropriate.
* Add the workflow to your SPOG view in Shippable:
  * Select your subscription from the dropdown menu in the left nav
  * Select the "+" icon in the upper right
  * Select the source control repo where your fork is, in the 'Add a Sync 
  Repository' section
* After processing completes, you should see the new jobs and resources now added 
to your Single Pane of Glass view

## Run the workflow 
* Right-click on the runSh job in the SPOG view named 'prov_kube_cluster' and run the job.
This will execute the KOPS commands as defined in shippable.jobs.yml.
  * This demo uses a custom scripting job type called 'runSh' in Shippable - 
  [learn more about 'runSh' jobs](http://docs.shippable.com/workflows/jobs/runSh/) 
* When your job completes, you should see new EC/2 instances in your AWS account. 
* At any time, right-click and run the `deprov_kube_cluster` job to terminate 
the cluster and the associated resources on AWS.
* When the job completes, you should now see all of the instances terminated in
EC/2.

With this approach, your entire team can easily manage infrastructure 
provisioning as a dedicated workflow or incorporate on-demand provisioning as 
a step in an end-to-end testing scenario.

Additional notes:
* This sample uses a state_store generated on S3 automatically by the KOPS tool. 
You can change the name of this S3 bucket by updating the value for KOPS_STATE_STORE 
in shippable.resources.yml under the resource named `kube_cluster_config`.
