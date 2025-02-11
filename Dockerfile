# Use an official Python runtime as a base image
# @see: https://hub.docker.com/_/python
FROM python:3

# Set the working directory in the *container*
WORKDIR /stack

# Install any needed packages specified in "requirements.txt"
COPY requirements.txt ./
RUN pip install --no-cache-dir -r requirements.txt

# Make port 8888 available to the world ouside the container
EXPOSE 8888

# Define the environment variable
ENV NAME=PD_IMAGINE

# Run JupyterLab when the container launches
CMD ["jupyter", "lab", "--ip='0.0.0.0'", "--port=8888", "--no-browser", "--allow-root", "--NotebookApp.token=''"]
