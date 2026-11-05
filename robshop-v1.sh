#!/bin/bash

amiId="ami-0055977a6e828a4f4"
instanceType="t3.micro"
domainName="daws92.store"
hostedZoneID="Z01595761DU804AX48D6A"
# user_id=$(id -u)

# if [ $user_id -ne 0 ]; then
#     echo "You are not root user, Please run the script as root user"
#     exit 1
# fi

for instance in $@
    do
        echo "Start Create ${instance} instance:: $(date +"%F %T")"

        instanceId=$(aws ec2 run-instances \
            --image-id ${amiId} \
            --instance-type ${instanceType} \
            --security-group "roboshop-common", "roboshop-${instance}" \
            --tag-specifications "ResourceType=instance, Tags=[{Key=Name, Value=roboshop-${instance}}]" \
            --query "Instances[0].InstanceId" \
            --output text
            )
        
        echo "Instance ID for ${instance} is: ${instanceId}"

    done