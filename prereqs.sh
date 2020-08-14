 #!/bin/bash
[ -d "../helm-nodejs-timestamp" ] && echo "Directory  ../helm-nodejs-timestamp exists, not repulling from github." || git clone https://github.com/bconner22/helm-nodejs-timestamp.git ../helm-nodejs-timestamp
export CLUSTER_NAME=$(grep 'clustername:' ../helm-nodejs-timestamp/values.yaml | tail -n1 | awk '{ print $2}')
export APP_NAME=$(grep 'appname:' ../helm-nodejs-timestamp/values.yaml | tail -n1 | awk '{ print $2}')
sudo curl --silent --location -o /usr/local/bin/kubectl   https://amazon-eks.s3.us-west-2.amazonaws.com/1.17.7/2020-07-08/bin/linux/amd64/kubectl
sudo chmod +x /usr/local/bin/kubectl
sudo pip install --upgrade awscli && hash -r
sudo yum -y install jq gettext bash-completion moreutils
echo 'yq() {
  docker run --rm -i -v "${PWD}":/workdir mikefarah/yq yq "$@"
}' | tee -a ~/.bashrc && source ~/.bashrc
for command in kubectl jq envsubst aws;   do     which $command &>/dev/null && echo "$command in path" || echo "$command NOT FOUND";   done
kubectl completion bash >>  ~/.bash_completion
. /etc/profile.d/bash_completion.sh
. ~/.bash_completion
echo 'export ALB_INGRESS_VERSION="v1.1.8"' >>  ~/.bash_profile
.  ~/.bash_profile
rm -vf ${HOME}/.aws/credentials
export ACCOUNT_ID=$(aws sts get-caller-identity --output text --query Account)
export AWS_REGION=$(curl -s 169.254.169.254/latest/dynamic/instance-identity/document | jq -r '.region')
test -n "$AWS_REGION" && echo AWS_REGION is "$AWS_REGION" || echo AWS_REGION is not set
echo "export ACCOUNT_ID=${ACCOUNT_ID}" | tee -a ~/.bash_profile
echo "export AWS_REGION=${AWS_REGION}" | tee -a ~/.bash_profile
aws configure set default.region ${AWS_REGION}
aws configure get default.region
aws sts get-caller-identity --query Arn | grep eks-admin -q && echo "IAM role valid" || echo "IAM role NOT valid"
ssh-keygen -q -t rsa -N '' -f ~/.ssh/id_rsa <<<y 2>&1 >/dev/null
aws ec2 import-key-pair --key-name ${CLUSTER_NAME} --public-key-material file://~/.ssh/id_rsa.pub
aws kms create-alias --alias-name alias/${CLUSTER_NAME} --target-key-id $(aws kms create-key --query KeyMetadata.Arn --output text)
export MASTER_ARN=$(aws kms describe-key --key-id alias/${CLUSTER_NAME} --query KeyMetadata.Arn --output text)
echo "export MASTER_ARN=${MASTER_ARN}" | tee -a ~/.bash_profile
curl --silent --location "https://github.com/weaveworks/eksctl/releases/latest/download/eksctl_$(uname -s)_amd64.tar.gz" | tar xz -C /tmp
sudo mv -v /tmp/eksctl /usr/local/bin
eksctl version
eksctl completion bash >> ~/.bash_completion
. /etc/profile.d/bash_completion.sh
. ~/.bash_completion
aws sts get-caller-identity
echo "Installing helm"
curl -sSL https://raw.githubusercontent.com/helm/helm/master/scripts/get-helm-3 | bash
helm repo add stable https://kubernetes-charts.storage.googleapis.com/
helm completion bash >> ~/.bash_completion
. /etc/profile.d/bash_completion.sh
. ~/.bash_completion
source <(helm completion bash)
echo "Installing newman"
npm list newman || npm install newman