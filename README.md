# scipy-docker-env
Docker environment for scipy development

## Motivation

Installing dependencies is a pain, and sometimes you don't want (or can't) install a bunch of packages on your machine. With this Dockerfile you will have an Ubuntu container already configured for scipy development. No need to install anything except Docker and docker-compose.

## Usage

Clone scipy:

```bash
$ git clone --recurse-submodules git@github.com:<your-username>/scipy.git
```
Copy the repo in the scipy root (or create a soft link):

```bash
$ cp scipy-docker-env path/to/scipy
```

generate the env file with your user info:

```bash
$ cd path/to/scipy/scipy-docker-env
$ echo -e "HOST_USERNAME=$USER\nHOST_UID=$(id -u)\nHOST_GID=$(id -g)" > .env
```

Passing `HOST_USERNAME`, `HOST_UID`, `HOST_GID` makes sure that the user inside the container matches yours on the host. This way the files created from inside the container will belong to you and not to `root`.

Now you can spin up the container:

```bash
$ docker-compose up -d
```

This container will run in the background, waiting to be used:

```bash
$ docker exec -it -u $USER <container_name> bash
```

## Scipy development

Once inside the container build scipy:

```bash
$ python3 setup.py build_ext --inplace
```

Install it:

```bash
$ sudo pip3 install -e .
```

To make sure this went well, open the Python interpreter and verify the scipy version:

```python
>>> import scipy
>>> print(scipy.__version__)
1.9.0.dev0+1339.6606c2e
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
