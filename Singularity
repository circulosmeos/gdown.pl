BootStrap: docker
FROM: perl

# This is the script that's executed when you don't call it with any script or shell to execute.
%runscript
        exec /usr/local/bin/gdown.pl "$@"

%setup
	cp gdown.pl ${SINGULARITY_ROOTFS}/usr/local/bin/

# These commands will be executed inside of the container during building.
%post
	apt-get update
	apt install -y wget
