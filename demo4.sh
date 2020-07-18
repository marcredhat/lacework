#!/usr/bin/env bash
	#https://www.redhat.com/sysadmin/getting-started-buildah

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
	buildah run $container bash -c lacework
