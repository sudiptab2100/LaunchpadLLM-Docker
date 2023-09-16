# Use a base image
FROM ubuntu:20.04

# Create a directory inside the container (optional)
WORKDIR /app

# Copy the local directory into the container
COPY /micro /app/

# Set environment variables to avoid interactive prompts
ENV DEBIAN_FRONTEND=noninteractive

# Update the package repository and install required packages
RUN apt-get update -y
RUN apt-get install -y wget
RUN apt-get install -y unzip
RUN apt-get install -y python3 python3-pip python3.8-venv
RUN apt-get install -y build-essential

# Install Java 17
RUN apt-get install -y openjdk-17-jdk

# Use 'bash' shell instead of 'sh' shell
SHELL ["/bin/bash", "-c"] 

RUN chmod +x setup.sh
RUN ./setup.sh

# Define the default command to run when the container starts (optional)
CMD ["/bin/bash"]
