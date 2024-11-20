# Croc Docker

A docker image for running [Croc](https://github.com/schollz/croc), a tool for sending files and folders securely between computers.

## Installation

To use the Croc Docker image, you need to have Docker (or a compatible alternative such as Rancher Desktop or Podman) installed on your machine. You can download and install Docker from [here](https://www.docker.com/get-started).

Then, just fetch the latest image from Docker:

```shell
docker pull matracey/croc-docker:latest
```

## Usage

### Basic Usage

To see the help message for Croc, you can run the following command:

```shell
# The default cmd is '--help'
docker run -it --rm matracey/croc-docker
## OR ##
docker run -it --rm matracey/croc-docker --help
```

### Sending Files

To send the current directory, you can use the following command:

```shell
docker run -it --rm -v "$(pwd):/$(pwd)" matracey/croc-docker send "$(pwd)"
## OR, zip it before sending ##
docker run -it --rm -v "$(pwd):/$(pwd)" matracey/croc-docker send --zip "$(pwd)"
```

### Helper Alias

Finally, you can create an alias for easier usage by adding the following line to your shell configuration file (e.g., .bashrc or .zshrc):

```shell
alias croc='docker run -it --rm -v "$(pwd):/$(pwd)" matracey/croc-docker'
```
