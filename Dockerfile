# === Use an official Ubuntu 24.04 (noble numbat) as a base image 
# @see: https://hub.docker.com/_/ubuntu
# @note: Ubuntu image has a default non-root user named `ubuntu`, with user id 1000, group id 1000 and this dockerfile is designed to use that one.
FROM ubuntu:24.04

# === Arguments ===
# Use the default non-root user on Ubuntu
ARG PD_USER_NAME='ubuntu'
ARG PD_USER_UID='1000'
ARG PD_USER_GID=$PD_USER_UID
# Specify the timezone
ARG PD_TIMEZONE='Asia/Tokyo'
# Set the locale
ARG PD_LOCALE='C.UTF-8'
# Set the workspace directory
ARG PD_WORKSPACE='wksp'
# Define an identifier
ARG PD_CONTAINER_NAME='pd-imagine'

# === Basic scaffolding ===
# Options for the shell:
# -e: Exit immediately if a command exits with a non-zero status (fail fast on errors).
# -u: Treat unset variables as an error and exit immediately (helps catch typos or missing env vars).
# -c: Read commands from the following string (this is required for Docker to pass the command as a string).
SHELL ["/bin/sh", "-euc"]

# Install basic packages
# @note: The here doc (<<-EOT) strips leading tabs from the content, allowing for cleaner indentation in the Dockerfile.
RUN <<-EOT
	export DEBIAN_FRONTEND=noninteractive
	apt-get update
	apt-get install -y --no-install-recommends \
		sudo \
		openssh-client gnupg \
		tzdata
	apt-get clean
	rm -rf /var/lib/apt/lists/*
EOT

# Grant sudo access to the default user
RUN <<-EOT
	echo "${PD_USER_NAME} ALL=(ALL) NOPASSWD:ALL" > /etc/sudoers.d/$PD_USER_NAME
	chmod 0440 /etc/sudoers.d/$PD_USER_NAME
EOT

# Create the necessary directory structure for gpg forwarding
# @note: This directory is automatically created on Ubuntu Desktop, but it does not exist by default for a Ubuntu docker image.
RUN <<-EOT
	mkdir -p -m 0700 /run/user/$PD_USER_UID
	chown $PD_USER_UID:$PD_USER_GID /run/user/$PD_USER_UID
EOT

# === Working environment setup ===
ENV TZ=$PD_TIMEZONE
ENV LANG=$PD_LOCALE
ENV CONTAINER=$PD_CONTAINER_NAME

# === Launchpad ===
# Execute the following commands as the non-root user
USER $PD_USER_NAME

# Set the working directory in the *container*
WORKDIR /home/$PD_USER_NAME/$PD_WORKSPACE

# Set the default command
CMD echo "PLEASE LOGIN TO THE CONTAINER AND RUN THE SERVICE MANUALLY" && \
	echo "@host: docker run -it <image-name> bash" && \
	echo "@docker: <your-command-here>"
