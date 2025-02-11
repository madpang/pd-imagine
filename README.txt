+++ header
@file: c0-container/pd-imagin/README.txt
@date:
- created on 2025-02-05
- updated on 2025-02-05
@author: madpang
+++

=== Introduction

This is a Docker image for image processing.
I used to be comfortable w/ MATLAB, but I shifting to more open-source tools.
I would like utilze Docker and Jupyter for a portable and reproducible development environment.

=== Usage

Execute the following command inside *this* folder to *build* the Docker image:
+++ shell
docker build -t pd-imagine .
+++

Execute the following command to *run* the Docker container:
+++ shell
docker run -p 8888:8888 -v <path-to-your-stack-folder>:/stack pd-imagine
# e.g.
# docker run -p 8888:8888 -v $(pwd):/stack pd-imagine
+++
The above command maps the host stack folder to the container's `/stack` directory.
