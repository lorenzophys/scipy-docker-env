FROM ubuntu:20.04

# Install git and Python
RUN DEBIAN_FRONTEND=noninteractive apt-get update && \
    DEBIAN_FRONTEND=noninteractive apt-get install -y \
    git \
    python3 \
    python3-pip \
    sudo

# BLAS and LAPACK, libatlas and the compilers
RUN DEBIAN_FRONTEND=noninteractive apt-get update && \
    DEBIAN_FRONTEND=noninteractive apt-get install -y \
    build-essential \
    gfortran \
    libatlas-base-dev \
    libblas3 \
    libblas-dev \
    liblapack3 \
    liblapack-dev

# Requirements
RUN pip3 install \
    cython \
    docutils==0.16 \
    flake8 \
    matplotlib \
    mypy \
    numpy \
    pybind11 \
    pydata-sphinx-theme \
    pytest \
    pythran \
    sphinx \
    sphinx-panels
