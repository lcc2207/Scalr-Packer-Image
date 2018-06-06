# Scalr Image build with Packer

## This is an example script that will build and AMI in AWS and create an Image in Scalr

# Requirments:
- packer install:  
  https://www.packer.io/
- scalr-ctl installed:  
  https://scalr-wiki.atlassian.net/wiki/spaces/docs/pages/72712203/Scalr-ctl+Command+Line+Tools
- Access/secret_key to AWS account . 
- AMI ID of the base AMI you want to use

# Items that will need updated in the script 'build-images.sh'
Note you can remove these from the script and export them in the Env or update the script

export config="<Path to your Scalr config file>"   
export AWS_AMIBASE="<AMI ID>""  
export AWS_AMI_user="ubuntu"  
export AWS_SUBNETID="<AWS SUBNET ID>"  
export AWS_SECURITY_GROUP="<AWS SECURITY GROUP ID>"  
export OSID=ubuntu-16-04  
export amidate=$(date +%H%I%Y)  
export AMINAME=Scalr-$OSID-$amidate  
export AWS_DEFAULT_REGION="<AWS REGION>"  
export packer_file="packer_ubuntu_scalr.json"  
