	#!/usr/bin/env bash
	#https://www.redhat.com/sysadmin/getting-started-buildah
        #https://access.redhat.com/documentation/en-us/red_hat_enterprise_linux/8/html/building_running_and_managing_containers/building-container-images-with-buildah_building-running-and-managing-containers
        set -o errexit

        # Create a container
        container=$(buildah from registry.access.redhat.com/ubi8/ubi:latest)

        # Labels are part of the "buildah config" command
        buildah config --label maintainer="Marc" $container

        # Grab the source code outside of the container
        curl -sSL https://raw.githubusercontent.com/lacework/go-sdk/master/cli/install.sh -o install.sh

        buildah copy $container ./install.sh /tmp/install.sh

        buildah run $container chmod +x /tmp/install.sh
        buildah run $container bash -c /tmp/install.sh

	#buildah run $container bash -c lacework

	#https://access.redhat.com/documentation/en-us/red_hat_enterprise_linux/8/html/building_running_and_managing_containers/building-container-images-with-buildah_building-running-and-managing-containers
	buildah commit  $container localhost/buildahlaceworkfromscratch
	#podman images
	#REPOSITORY                                    TAG      IMAGE ID       CREATED              SIZE
	#localhost/buildahlaceworkfromscratch          latest   9ab8b43eda3d   About a minute ago   226 MB
	printf "\n\n ***** Configuring Lacework and authenticating *****\n\n"
	#podman run --name=fromscratchlaceworkpodman -it localhost/buildahlaceworkfromscratch /bin/bash
	#'/bin/sh' -c 'lacework configure --account "<account>" --api_key "<API key>" --api_secret "<API secret>"'
        buildahctr=`buildah containers | tail -n 1 | awk '{print $5}'`
	buildah run $buildahctr bash -c 'lacework configure --account "<account>" --api_key "<API key>" --api_secret "<API secret>"'
	#podman run --name=fromscratchlaceworkpodman -it localhost/lacework:latest /bin/bash
        #laceworkcontainer=`podman container ls  | grep fromscratchlacework |  awk '{print $1'}`

	printf "\n\n ***** Run commands inside Lacework container using podman *****\n\n"
	buildah run $buildahctr bash -c  'lacework events list | more'
