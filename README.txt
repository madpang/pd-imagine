+++ header
@file: c0-container/pd-imagin/README.txt
@date:
- created on 2025-02-05
- updated on 2025-02-11
@author: madpang
+++

=== Introduction

This is a Docker image for image processing.
I used to be comfortable w/ MATLAB, but I shifting to more open-source tools.
I would like utilze Docker and Jupyter for a portable and reproducible development environment.

=== Usage

--- Standalone

Execute the following command inside *this* folder to *build* the Docker image:
+++ cmd from host
# execute from *this* folder
docker build -t pd-imagine .
+++

Execute the following command to launch the container and sit inside the interactive shell of the container:
+++ cmd from host
docker run -it -p 8888:8888 -v <path-to-your-stack-folder>:/workspace pd-imagine /bin/bash
# e.g., docker run -it -p 8888:8888 -v $(pwd):/workspace pd-imagine /bin/bash
+++

Then you can start JupyterLab server by executing the following command inside the container:
+++ cmd from container
jupyter lab --ip=0.0.0.0 --port=8888 --no-browser --NotebookApp.token=''
+++

After the server is started, you can access the JupyterLab server by opening a web browser from your client machine and navigating to `http://host-server-address:8888`.

--- Use through VS Code Dev Containers Extension

You can also use this Docker image as a development container in VS Code.

1. Create a workspace folder, e.g. `~/Workspace/stack/2025-02-11`
2. And create a `.devcontainer` folder inside the workspace folder.
3. Copy (or symlink) the `Dockerfile` and `devcontainer.json` files from this folder to the `.devcontainer` folder.
4. Open the workspace folder in VS Code.
5. Click the "Reopen in Container" button in the bottom right corner of the window.

@see: [Developing inside a Container](https://code.visualstudio.com/docs/devcontainers/containers)
