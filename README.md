# EKS cluster launch with application exposing a  REST endpoint

## What does this do?  

1. Install all tools needed to interact with your EKS cluster
2. Create your EKS cluster
3. Deploy the node.js-timestamp app

## Prerequisites(TODO Tighten up the IAM so admin isn't required)

Either:

An Amazon Linux Cloud9 instance with an admin IAM role named 'eksadmin' attached

OR

A Linux(RedHat/yum based) machine with an admin IAM named 'eksadmin' attached TODO case for multiple Linuxes


## How to use this repo

1. Go to your helm-nodejs-timestamp repo(example can be forked at https://github.com/bconner22/nodejs-timestamp), and set your clustername and appname in the values.yaml file. Commit this to master.)
`./oneclick.sh`

## Cleanup

To delete the EKS cluster:
`./eks_cleanup.sh <name of the cluster to delete>`

