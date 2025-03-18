+++ header
@file: pd-imagine/README.txt
@date:
- created on 2025-02-05
- updated on 2025-03-18
@author: madpang
+++

=== Introduction

This is a Docker image providing a Python development environment for image processing and computer vision tasks.

It can either be launched via standard Docker commands or through the Visual Studio Code Dev Containers extension.

When used as a VS Code dev container, you get the following extra features:
1. SSH agent forwarding
2. GPG agent forwarding
3. Git credential sharing
4. Interactive Python Window
Those bonus features are applicable even when using Remote SSH extension to connect to a remote server.

NOTE, you will login to the container as a non-root user `panda`.

=== Usage

--- When used as a standalone Docker container of a Jupyter server

Execute the following commands to *build* the Docker image:
+++ cmd @host
git clone --branch main --single-branch https://github.com/madpang/pd-imagine.git
cd pd-imagine
docker build -t pd-imagine .
+++

Execute the following command to launch the container and login to the interactive shell of the container:
+++ cmd @host
docker run -it -p 8888:8888 -v <path-to-your-stack-folder>:/home/panda/workspace/<your-project-name> pd-imagine /bin/bash
# e.g., docker run -it -p 8888:8888 -v ~/workspace/pd-imagine:/home/panda/workspace/pd-imagine pd-imagine /bin/bash
+++
Then start the JupyterLab server by executing the following command inside the container:
+++ cmd @container
jupyter lab --ip=0.0.0.0 --port=8888 --no-browser --NotebookApp.token=''
+++
After the server is started, you can access the JupyterLab server by opening a web browser from your client machine and navigating to `http://host-server-address:8888`.

--- When used through VS Code Dev Containers Extension

To use this Docker image as a dev container in VS Code:
1. `cd` into your <project-folder>
2. `git submodule add --branch main https://github.com/madpang/pd-imagine.git .devcontainer`
3. Open the workspace folder in VS Code.
4. Click the "Reopen in Container" button in the bottom right corner of the window.
@see: [Developing inside a Container](https://code.visualstudio.com/docs/devcontainers/containers).
If you do not want to embed this project as a submodule, you can also create a `.devcontainer` symbolic link to the `pd-imagine` folder.

NOTE, currently, if using "open folder in dev container" feature in VS Code, the container will NOT automatically stop when you close the connection.
You need to manually stop the container by executing `docker stop <container-id>` (in a SSH session) on the host machine.

=== Guideline for contribution

1. Fork this repository
2. Create your feature or bugfix branch from the `develop` branch to address one of the issue in the `tickets.txt` file
3. Make pull request to the `develop` branch

@note: issue tickets are published through the develop branch, one can file a new through the issue tracker on the GitHub page.
