
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
echo "*************   eksctl un-installation - start *************"
eksctl delete cluster --config-file=eks.yaml &>>$LOGFILE
VALIDATE $? "Deleted EKS Cluster"
echo "*************   eksctl un-installation - end *************"