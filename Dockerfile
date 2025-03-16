# === Use an official Ubuntu image as the base layer
# @see: https://hub.docker.com/_/ubuntu
FROM ubuntu:24.04

# Define a environment variable as an identifier
ENV MY_ENV="pd-imagine"

# Copy the requirements file for Python packages
COPY requirements.txt /tmp/pip-tmp/
# Copy the entrypoint script
COPY entrypoint.sh /tmp/startup/
RUN chmod +x /tmp/startup/entrypoint.sh
# @note: Copied files are owned by root

# Set the default shell in building the image
# @note: The default shell command for Linux is `["/bin/sh", "-c"]`, which lacks some modern features, such as `source`, etc.
SHELL ["/bin/bash", "-c"]

# === Install necessary tools
RUN apt-get update && apt-get install -y \
	sudo \
	openssh-client gnupg curl git \
	python3 python3-pip python3-venv \
	&& apt-get clean \
	&& rm -rf /var/lib/apt/lists/*

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

# Execute the following commands as the non-root user
USER $USERNAME

# Create the necessary directory structure for gpg socket
RUN sudo mkdir -m 0755 /run/user \
	&& sudo mkdir -m 0700 /run/user/$USER_UID \
	&& sudo chown $USER_UID:$USER_GID /run/user/$USER_UID

# === Install Python packages
# @note: Creating a virtual environment is necessary on a Ubuntu based image, to circumvent the PEP 668 (Externally Managed Environments) issue.
RUN python3 -m venv /home/$USERNAME/.venv \
	&& source /home/$USERNAME/.venv/bin/activate \
	&& pip install --upgrade pip \
	&& pip install --no-cache-dir -r /tmp/pip-tmp/requirements.txt

# === Setup the launch behavior
# Set the entrypoint script
ENTRYPOINT ["/tmp/startup/entrypoint.sh"]
# Set the default command (to keep the container alive)
CMD ["sleep", "infinity"]

# Set the working directory in the *container*
WORKDIR /home/$USERNAME/workspace
