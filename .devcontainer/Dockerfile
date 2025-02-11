# Use an official Python runtime as a base image
# @see: https://hub.docker.com/_/python
FROM python:3

# Set up a non-root user for development inside VS Code devcontainer
ARG USERNAME=panda
ARG USER_UID=1000
ARG USER_GID=$USER_UID

RUN apt-get update && apt-get install -y \
	sudo \
	git \
	curl \
	&& rm -rf /var/lib/apt/lists/*

# Create the user and grant sudo access
RUN groupadd --gid $USER_GID $USERNAME \
    && useradd --uid $USER_UID --gid $USER_GID -m $USERNAME \
    && echo "$USERNAME ALL=(ALL) NOPASSWD:ALL" > /etc/sudoers.d/$USERNAME \
    && chmod 0440 /etc/sudoers.d/$USERNAME

# Set the working directory in the *container*
WORKDIR /app

# Install any needed packages specified in "requirements.txt"
COPY requirements.txt /tmp/pip-tmp/
RUN pip install --no-cache-dir -r /tmp/pip-tmp/requirements.txt \
	&& rm -rf /tmp/pip-tmp

# Default shell for VS Code terminal
SHELL ["/bin/bash", "-c"]

# Define the environment variable
ENV NAME="pd-imagine"

# Set the non-root user
USER $USERNAME

# Set the default command (keep the container alive)
CMD ["sleep", "infinity"]
