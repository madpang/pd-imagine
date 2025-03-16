# === Use an official (Debian-based) Python runtime as a base image 
# @see: https://hub.docker.com/_/python
FROM python:3.13-slim-bookworm

# Define a environment variable as an identifier
ENV MY_ENV="pd-imagine"

# Copy the requirements file for Python packages
# @note: Copied files are owned by root
COPY requirements.txt /tmp/pip-tmp/requirements.txt

# === Install necessary packages
# Install basic tools
RUN apt-get update && apt-get install -y \
	sudo \
	openssh-client gnupg curl git \
	&& apt-get clean \
	&& rm -rf /var/lib/apt/lists/*

# Install Python packages
RUN pip install --no-cache-dir -r /tmp/pip-tmp/requirements.txt \
	&& rm -rf /tmp/pip-tmp

# === Setup a non-root user and grant sudo access for development inside VS Code devcontainer
# @note:
# - Ubuntu image may have automatically created a default non-root user---named `ubuntu`, with user id 1000, group id 1000
# - If you use Debian based image, you need to create that non-root user manually
ARG USERNAME=panda
ARG USER_UID=1000
ARG USER_GID=$USER_UID

RUN groupadd --gid $USER_GID $USERNAME \
	&& useradd --uid $USER_UID --gid $USER_GID -m $USERNAME \
	&& echo "$USERNAME ALL=(ALL) NOPASSWD:ALL" > /etc/sudoers.d/$USERNAME \
	&& chmod 0440 /etc/sudoers.d/$USERNAME

# Execute the following commands as the non-root user
USER $USERNAME

# Create the necessary directory structure for gpg socket
RUN sudo mkdir -m 0755 /run/user \
	&& sudo mkdir -m 0700 /run/user/$USER_UID \
	&& sudo chown $USER_UID:$USER_GID /run/user/$USER_UID

# Fix the permissions of the home directory
RUN chmod 750 /home/$USERNAME

# === Setup the launch behavior
# Set the default command (to keep the container alive)
CMD ["sleep", "infinity"]

# Set the working directory in the *container*
WORKDIR /home/$USERNAME/workspace
