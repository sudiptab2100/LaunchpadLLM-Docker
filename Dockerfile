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

# Install git-lfs
RUN apt-get install -y git
RUN apt-get install -y curl
RUN curl -s https://packagecloud.io/install/repositories/github/git-lfs/script.deb.sh | bash
RUN apt-get install -y git-lfs

# Download Models
RUN cd LaunchpadLLM/files && \
    git lfs install && \
    git clone https://huggingface.co/sentence-transformers/all-MiniLM-L6-v2 && \
    wget -c https://huggingface.co/TheBloke/Speechless-Llama2-Hermes-Orca-Platypus-WizardLM-13B-GGUF/resolve/main/speechless-llama2-hermes-orca-platypus-wizardlm-13b.Q5_K_M.gguf

# Install Python and Python virtual environment
RUN apt-get install -y python3 python3-pip python3.8-venv
RUN apt-get install -y build-essential

# Install Java 17
RUN apt-get install -y openjdk-17-jdk

# Use 'bash' shell instead of 'sh' shell
SHELL ["/bin/bash", "-c"] 

# Download files and setup Python
RUN cd LaunchpadLLM && \
    python3 -m venv env && \
    source env/bin/activate && \
    export CMAKE_ARGS="-DLLAMA_CUBLAS=on" && \
    export FORCE_CMAKE=1 && \
    pip install --trusted-host pypi.python.org --trusted-host pypi.org --trusted-host files.pythonhosted.org -r requirements.txt && \
    deactivate && \
    cd ..

# Uninstall unnecessary packages
RUN apt remove -y git
RUN apt remove -y git-lfs
RUN apt remove -y curl
RUN apt remove -y wget

# Define the default command to run when the container starts (optional)
CMD ["/bin/bash"]