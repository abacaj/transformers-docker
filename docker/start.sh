#!/bin/bash

echo "container started"

if [[ $PUBLIC_KEY ]]
then
    mkdir -p ~/.ssh
    chmod 700 ~/.ssh
    cd ~/.ssh
    echo $PUBLIC_KEY >> authorized_keys
    chmod 700 -R ~/.ssh
    cd /
    service ssh start
fi

if [[ $JUPYTER_PASSWORD ]]
then
    cd /
    jupyter lab --allow-root --no-browser --port=8888 --ip=* --ServerApp.terminado_settings='{"shell_command":["/bin/bash"]}' --ServerApp.token=$JUPYTER_PASSWORD --ServerApp.allow_origin=* --ServerApp.preferred_dir=/workspace > jupyter.log 2>&1 & disown
fi

# create the env
mkdir -p transformers
python -m venv --system-site-packages /usr/local/lib/python3.10/dist-packages transformers/venv

# load env
echo "env loaded"
cd /transformers && /bin/bash --rcfile /transformers/venv/bin/activate