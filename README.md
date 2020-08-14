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

1. Set your helm-nodejs-timestamp repo URL on line 2 of prereqs.sh.  If your helm-nodejs-timestamp repo's master branch has its clustername, appname, and image 
   like you want them, then you can skip step 2 and 3.
2. Clone your helm-nodejs-timestamp repo(example can be forked at https://github.com/bconner22/nodejs-timestamp) adjacent to this repo, like this:
~/environment/\
   eks-infra-build/\
   nodejs-timestamp-repo/\

3. In the helm-nodejs-timestamp repo, populate values.yaml with your desired EKS `clustername`, `appname`, and `image
4. In this repo, run `./oneclick.sh`

## Cleanup

To delete the EKS cluster:
`./eks_cleanup.sh <name of the cluster to delete>`

