#!/bin/bash

export config=~/.scalr/default.yaml
export AWS_AMIBASE="ami-xxxx"
export AWS_AMI_user="ubuntu"
export AWS_SUBNETID="subnet-xxxx"
export OSID=ubuntu-16-04
export amidate=$(date +%H%I%Y)
export AMINAME=Scalr-$OSID-$amidate
export AWS_DEFAULT_REGION="us-xxx-1"
export packer_file="packer_ubuntu_scalr.json"

# build the image
packer build $packer_file 2>&1 | tee output.txt
export amiid=$(tail -2 output.txt | head -2 | awk 'match($0, /ami-.*/) { print substr($0, RSTART, RLENGTH) }')

# get the AWS AMI ID from the packer output
cat scalr-new-image.json | jq ".cloudImageId=\"$amiid\""| jq ".os.id=\"$OSID\""| jq ".cloudLocation=\"$AWS_DEFAULT_REGION\"" | jq ".name=\"$AMINAME\"" > $AMINAME.json

# import the AWS image into Scalr as Image
export imageid=$(scalr-ctl images register --stdin < $AMINAME.json | jq '.data.id' | tr -d '"')

# clean up
rm output.txt
rm $AMINAME.json
