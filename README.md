# Transformers Docker Container

This container runs cuda + pytorch with attached python env. This allows you to restart the container while maintaining python dependencies. It is recommended to use a docker volume as shown below so that the dependencies you install for your project are retained.

I have been using this container to run inference, experiment and train transformer models for more than 3 months without issues.

The workflow:

1. Run the container, it starts a shell with env loaded
2. Install your dependencies
3. Attach using vscode > Dev Containers: Attach to Running Container
4. Write code
5. Run code

Versions:

- python 3.10
- cuda 12.0.0
- torch 2.0

## Run container from docker hub

Recommended to add a volume:

```bash
docker volume create transformers
```

Run container with a maximum memory allocation, assign as much RAM as you need/system can support minus a small window. In some cases assigning max system memory could result in your system freezing when loading large models:

```properties
docker run --gpus all --memory 64g --memory-swap -1 -it -v transformers:/transformers abacaj90/pytorch2:cuda12.0.0
```

## Using VSCode

Steps:

- Attach to the dev container
- Install python extension into the container from vscode extension tab
- Select interpreter located at: `/transformers/venv/bin/python`

## Build your own container

```properties
docker build -t pytorch2:cuda12.0.0 -f docker/Dockerfile docker/
```

## Run with jupyter started on port 8888

Jupyter:

- Password is set to 1234
- Jupyter will use the venv
- Runs detached in background
- You can still use VScode to attach to container if you like

```properties
docker run --gpus all --memory 64g --memory-swap -1 -d -v transformers:/transformers -e JUPYTER_PASSWORD=1234 -p 8888:8888 abacaj90/pytorch2:cuda12.0.0
```

Visit url:
[Jupyter localhost](http://127.0.0.1:8888/lab)
