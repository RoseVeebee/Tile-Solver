# syntax=docker/dockerfile:1
# A Dockerfile that sets up a full Gym install with test dependencies
ARG PYTHON_VERSION=3.7
FROM python:$PYTHON_VERSION
ARG MINIGRID_DIR=/usr/local/minigrid

SHELL ["/bin/bash", "-o", "pipefail", "-c"]

RUN apt-get -y update \
    && apt-get install --no-install-recommends -y \
    xvfb

COPY requirements.txt pyproject.toml $MINIGRID_DIR/
COPY . $MINIGRID_DIR
WORKDIR $MINIGRID_DIR

RUN pip install .[wfc,testing] --no-cache-dir

RUN ["chmod", "+x", "/usr/local/minigrid/docker_entrypoint"]

ENTRYPOINT ["/usr/local/minigrid/docker_entrypoint"]
