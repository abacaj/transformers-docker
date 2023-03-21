# Transformers Docker Container

This container runs cuda + pytorch with a auto-start python env. This allows you to restart the container while maintaining python dependencies. It is recommended to use a docker volume as shown below so that the dependencies you install for your project is retained.

I have been using this container to run inference, experiment and train transformer models for more than 3 months without issues.

## Run container from docker hub

Recommended to add a volume:

```bash
docker volume create transformers
```

Run container with limited memory allocation, assign as much RAM as you need/system can support minus a small window. In some cases assigning max system memory could result in your system freezing when loading large models:

```bash
docker run --gpus all --memory 64g --memory-swap -1 -it -v transformers:/transformers -p 8888:8888 abacaj90/pytorch2:cuda12.0.0-1 /bin/bash -c './start.sh'
```

## Build your own container

```bash
docker build -t pytorch2:cuda12.0.0 -f docker/Dockerfile docker/
```
