# Use NVIDIA's official CUDA base image with Ubuntu 22.04
FROM nvidia/cuda:12.1.1-cudnn8-runtime-ubuntu22.04

# Set non-interactive frontend for apt
ENV DEBIAN_FRONTEND=noninteractive

# Install basic utilities and Python
RUN apt-get update && apt-get install -y --no-install-recommends \
    build-essential \
    python3 \
    python3-pip \
    python3-dev \
    git \
    curl \
    ca-certificates \
    && rm -rf /var/lib/apt/lists/*

# Ensure python3 is the default
RUN ln -s /usr/bin/python3 /usr/bin/python

# Upgrade pip
RUN python -m pip install --upgrade pip

# Install PyTorch (latest version compatible with CUDA 12.1)
RUN pip install torch torchvision torchaudio --index-url https://download.pytorch.org/whl/cu121

# Install additional Python packages
COPY requirements.txt /
RUN pip install --no-cache-dir -r /requirements.txt
# Set working directory
WORKDIR /workspace

# Default command
CMD [ "python" ]