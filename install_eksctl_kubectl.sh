#!/bin/bash

USERID=$(id -u)
TIMESTAMP=$(date +%F-%H-%M-%S)
SCRIPT_NAME=$(echo $0 | cut -d "." -f1)
LOGFILE=/tmp/$SCRIPT_NAME-$TIMESTAMP.log

R="\e[31m"
G="\e[32m"
N="\e[0m"

echo "Script started executing at:$TIMESTAMP"

VALIDATE(){
    if [ $1 -ne 0 ]
    then 
        echo -e "$2...$R FAITURE $N"
        exit 1
    else
        echo -e "$2.. $G SUCCESS $N"
    fi
}

if [ $USERID -ne 0 ]
then
    echo "Please run this script with root access."
    exit 1 # manually exit if error comes.
else
    echo "You are super user."
fi

echo "*************   eksctl installation - start *************"
curl --silent --location "https://github.com/weaveworks/eksctl/releases/latest/download/eksctl_$(uname -s)_amd64.tar.gz" | tar xz -C /tmp &>>$LOGFILE
VALIDATE $? "Installing eksctl "

sudo mv /tmp/eksctl /usr/local/bin &>>$LOGFILE
VALIDATE $? "Moving eksctl from tmp to bin folder"

eksctl version &>>$LOGFILE
VALIDATE $? "eksctl version"
echo "*************   eksctl installation - end *************"

echo "*************   eksctl installation - start *************"
curl -O https://s3.us-west-2.amazonaws.com/amazon-eks/1.30.0/2024-05-12/bin/linux/amd64/kubectl &>>$LOGFILE
VALIDATE $? "Installing kubectl"

chmod +x ./kubectl &>>$LOGFILE
VALIDATE $? "changing kubectl file permission to execute"

mv kubectl  /usr/local/bin/ &>>$LOGFILE
VALIDATE $? "Moving kubectl from current folder to bin folder"

kubectl version --client &>>$LOGFILE
VALIDATE $? "kubectl version"
echo "*************   eksctl installation - end *************"


echo "*************   eksctl cluster creation started *************"
eksctl create cluster --config-file=eks.yaml &>>$LOGFILE
VALIDATE $? "eksctl cluster creation process"
echo "*************   eksctl cluster creation completed *************"
