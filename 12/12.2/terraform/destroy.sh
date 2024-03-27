export YC_TOKEN=`yc config list | grep token | awk '{print $2}'`
export YC_CLOUD_ID=`yc config list | grep cloud-id | awk '{print $2}'`
export YC_FOLDER_ID=`yc config list | grep folder-id | awk '{print $2}'`
export YC_ZONE=`yc config list | grep zone | awk '{print $2}'`

terraform destroy
