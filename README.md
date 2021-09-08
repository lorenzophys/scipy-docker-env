# scipy-docker-env
Docker environment for scipy development

## Motivation

Installing dependencies is a pain, and sometimes you don't want (or can't) install a bunch of packages on your machine. With this Dockerfile you will have an Ubuntu container already configured for scipy development. No need to install anything except Docker.

## Usage

Clone scipy:

```bash
$ git clone --recurse-submodules git@github.com:<your-username>/scipy.git
```
Copy the Dockerfile in the scipy root:

```bash
$ cp Dockerfile path/to/scipy
```

and build the image:

```bash
$ cd path/to/scipy
$ docker build \
    -t scipy-dev \
    --build-arg SCIPY_DIR="$(pwd)" \
    --build-arg HOST_USER=$USER \
    --build-arg HOST_UID=$(id -u) \
    --build-arg HOST_GID=$(id -g) \
    --no-cache . 
```

Passing `HOST_USER`, `HOST_UID`, `HOST_GID` to `--build-arg` makes sure that the user inside the container matches yours on the host. This way the files created from inside the container will belong to you and not to `root`.

Now you can run the container:

```bash
$ docker run -it -v "$(pwd)":"$(pwd)" --name scipy-env scipy-dev /bin/bash
```

This will mount the scipy directory into the container recreating the directory structure you have on your host machine.

## Scipy development

Once inside the container build scipy:

```bash
$ python3 setup.py build_ext --inplace
```

install it:

```bash
$ pip3 install -e .
```

and to make sure this went well, open the python interpreter and verify the scipy version:

```python
>>> import scipy
>>> print(scipy.__version__)
1.8.0.dev0+1523.7e30968
```

Run the tests to make sure everything works properly:

```bash
$ python3 runtests.py -v
```

Also remember to set upstream:

```bash
$ git remote add upstream https://github.com/scipy/scipy.git
```

If your global credentials are different from the ones you want to use for scipy, remember to set `user.name` and `user.email` to the desired github account:

```bash
$ git config user.user <your user>
$ git config user.email <your email>
```




