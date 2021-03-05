curl -sL https://aka.ms/InstallAzureCLIDeb | sudo bash

account_name=$(cat storage_name.txt | xargs echo )
container_name=$(cat cotainer_name.txt | xargs echo )
storage_key=$(cat storage_key.txt | xargs echo )

az storage blob upload --account-name $account_name   --container-name $container_name  --name test1.txt --file test1.txt --account-key $storage_key

