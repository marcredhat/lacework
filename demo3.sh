#!/bin/bash
printf "\n\n ***** Lacework container on Docker-less systems: *****\n\n"
printf "\n\n ***** 1) Buildah Lacework container on a Docker-less system *****\n\n"
printf "\n\n ***** 2) Push Lacework container to quay.io registry *****\n\n"
printf "\n\n ***** 3) Configure Lacework and authenticate*****\n\n"
printf "\n\n ***** 4) Run commands inside Lacework container using podman *****\n\n"

git clone https://github.com/lacework/go-sdk.git
cd go-sdk/
podman  login -u="marcf5" -p="<encrypted password from quay.io" quay.io

rm -rf Dockerfile
wget https://raw.githubusercontent.com/lacework/go-sdk/master/cli/images/ubi-8/Dockerfile

printf "\n\n ***** Buildah'ing lacework container *****\n\n"
buildah bud  -t lacework:latest .

printf "\n\n ***** pushing localhost/lacework to quay.io/marcf5/lacework *****\n\n"
podman push localhost/lacework:latest  quay.io/marcf5/lacework
podman images
#https://access.redhat.com/documentation/en-us/red_hat_enterprise_linux/8/html/building_running_and_managing_containers/working-with-containers_building-running-and-managing-containers
#podman run --name=marclaceworkpodman -it localhost/lacework:latest /bin/bash
laceworkcontainer=`podman container ls  | grep lacework |  awk '{print $1'}`

#To create a set of API keys, log in to your Lacework account via WebUI and navigate to Settings > API Keys and click + Create New.
#Enter a name for the key and an optional description, then click Save.
#To get the secret key, download the generated API key file.

printf "\n\n ***** Configuring Lacework and authenticating *****\n\n"
printf "\n\n ***** Press <ENTER> multiple times *****\n\n"
podman exec -i $laceworkcontainer '/bin/sh' -c 'lacework configure --account "<account>" --api_key "<API key>" --api_secret "<API secret>"'

printf "\n\n ***** Run commands inside Lacework container using podman *****\n\n"
podman exec -i $laceworkcontainer '/bin/sh' -c 'lacework events list | more'
