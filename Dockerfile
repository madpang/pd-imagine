# === Use an official Ubuntu image as the base layer
# @see: https://hub.docker.com/_/ubuntu
FROM ubuntu:24.04

# Define a environment variable as an identifier
ENV MY_ENV="pd-imagine"

# === Install basic tools
RUN apt-get update && apt-get install -y \
	sudo \
	openssh-client \
	gnupg \
	curl \
	git \
	&& apt-get clean \
	&& rm -rf /var/lib/apt/lists/*

COPY entrypoint.sh /tmp/startup/
RUN chmod +x /tmp/startup/entrypoint.sh

# === Setup a non-root user and grant sudo access for development inside VS Code devcontainer
# @note:
# - Ubuntu image may have automatically created a default non-root user---named `ubuntu`, with user id 1000, group id 1000
# - If you use Debian based image, you need to create that non-root user manually
#   +++ cmd
#   groupadd --gid $USER_GID $USERNAME
#   useradd --uid $USER_UID --gid $USER_GID
#   +++
ARG USERNAME=ubuntu
ARG USER_UID=1000
ARG USER_GID=$USER_UID

RUN echo "$USERNAME ALL=(ALL) NOPASSWD:ALL" > /etc/sudoers.d/$USERNAME \
	&& chmod 0640 /etc/sudoers.d/$USERNAME

# Set the non-root user
USER $USERNAME

RUN sudo mkdir -m 0755 /run/user \
	&& sudo mkdir -m 0700 /run/user/$USER_UID \
	&& sudo chown $USER_UID:$USER_GID /run/user/$USER_UID

# Set the working directory in the *container*
WORKDIR /home/$USERNAME/workspace

# Install any needed packages specified in "requirements.txt"
# COPY requirements.txt /tmp/pip-tmp/
# RUN pip install --no-cache-dir -r /tmp/pip-tmp/requirements.txt \
# 	&& rm -rf /tmp/pip-tmp

# Default shell for 
# SHELL ["/bin/bash", "-c"]

# === Setup the launch behavior
# Set the startup script
# ENTRYPOINT ["/tmp/startup/entrypoint.sh"]
# Set the default command (to keep the container alive)
CMD ["sleep", "infinity"]
