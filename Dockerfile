FROM ubuntu:20.04

# Read the variables passed through --build-arg
ARG SCIPY_DIR
ARG HOST_USER
ARG HOST_UID
ARG HOST_GID

ENV DEBIAN_FRONTEND=noninteractive

# Install git and Python
RUN apt-get update && apt-get install -y \
    git \
    python3 \
    python3-pip

# BLAS and LAPACK, libatlas and the compilers
RUN apt-get update && apt-get install -y \
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

# This will create a user inside the container that matches your user on host
RUN groupadd -g ${HOST_GID} ${HOST_USER} \
    && useradd \
    --create-home \
    --shell /bin/bash \
    --uid $HOST_UID \
    --gid $HOST_GID \
    --home-dir /home/$HOST_USER \
    $HOST_USER

# Adjust the permissions
RUN chown ${HOST_USER}:${HOST_USER} /home/${HOST_USER}

WORKDIR $SCIPY_DIR

USER $HOST_USER
