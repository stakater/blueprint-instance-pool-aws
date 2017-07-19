# blueprint-instance-pool-aws
This blueprint contains modules that are used to set up a best practices instance pool in your AWS account.

- Instance Pool
  - Launch Configuration
  - Auto Scaling Group
  - Auto Scaling Group Policy

## What is a blueprint?

At Stakater, we've taken the thousands of hours we spent building infrastructure on AWS and condensed all that experience and code into pre-built blueprints or packages or modules. Each blueprint is a battle-tested, best-practices definition of a piece of infrastructure, such as a VPC, ECS cluster, or an Auto Scaling Group. Modules are versioned using Semantic Versioning to allow Stakater clients to keep up to date with the latest infrastructure best practices in a systematic way.


#### NOTE: 
Any changes made to this repository should also be reflected in its respective clone for kubernetes (https://github.com/stakater/blueprint-instance-pool-k8s-aws). 
Both repositories should contain same code with the difference of kubernetes specific tags on resources of the clone repositroy `blueprint-instance-pool-k8s-aws`. 
