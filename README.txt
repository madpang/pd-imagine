+++ header
@file: pd-imagine/README.txt
@date:
- created on 2025-02-05
- updated on 2025-02-12
@author: madpang
+++

=== Introduction

This is a Docker image for image processing.
I used to be comfortable w/ MATLAB, but I shifting to more open-source tools.
I would like utilze Docker and Jupyter for a portable and reproducible development environment.

NOTE, `Dockerfile` and `requirements.txt` are put in the `.devcontainer` folder only for the convenience of using this Docker image as a VS Code dev container.
It is NOT intrisic to the Docker image itself---you may just `cd` into `.devcontainer` folder and build the Docker image from there.

=== Usage

--- Standalone

Execute the following command to *build* the Docker image:
+++ cmd from host
git clone --branch main --single-branch https://github.com/madpang/pd-imagine.git
cd pd-imagine
docker build -t pd-imagine .
+++

Execute the following command to launch the container and sit inside the interactive shell of the container:
+++ cmd from host
docker run -it -p 8888:8888 -v <path-to-your-stack-folder>:/app pd-imagine /bin/bash
# e.g., docker run -it -p 8888:8888 -v $(pwd):/app pd-imagine /bin/bash
+++

Then you can start JupyterLab server by executing the following command inside the container:
+++ cmd from container
jupyter lab --ip=0.0.0.0 --port=8888 --no-browser --NotebookApp.token=''
+++

After the server is started, you can access the JupyterLab server by opening a web browser from your client machine and navigating to `http://host-server-address:8888`.

--- Use through VS Code Dev Containers Extension

You can also use this Docker image as a development container in VS Code:
1. `cd` into your <project-folder>
2. git submodule add --branch main https://github.com/madpang/pd-imagine.git .devcontainer
3. Open the workspace folder in VS Code.
4. Click the "Reopen in Container" button in the bottom right corner of the window.
@see: [Developing inside a Container](https://code.visualstudio.com/docs/devcontainers/containers)

NOTE, when launching the container using the VS Code Dev Containers extension, a *bind mount* volume is automatically created between the host and the container. The workspace folder in the host is mounted to the `/workspace` folder in the container.
But one can also specify additional volumes in the `devcontainer.json` file, using `mounts` key.
@see: [Mounts](https://code.visualstudio.com/remote/advancedcontainers/add-local-file-mount)

NOTE, currently, if  using "open folder in dev container" on a remote server through remote-ssh extension, the container will NOT automatically stop when you close the connection.
You need to manually stop the container by executing `docker stop <container-id>` (in a SSH session).

=== Guideline for contribution

1. Fork the repository
2. Create your feature or bugfix branch from the `develop` branch to address one of the issue in the `tickets.txt` file
3. Make pull request to the `develop` branch

@note: issue tickets are published through the develop branch, one can file a new through the issue tracker on the GitHub page.
