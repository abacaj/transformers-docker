ARG BASE_IMAGE=nvidia/cuda:12.0.0-cudnn8-devel-ubuntu22.04

FROM ${BASE_IMAGE} as dev-base

WORKDIR /

RUN mkdir /workspace

SHELL ["/bin/bash", "-o", "pipefail", "-c"]
ENV DEBIAN_FRONTEND noninteractive\
    SHELL=/bin/bash
RUN apt-get update --yes && \
    # - apt-get upgrade is run to patch known vulnerabilities in apt-get packages as
    #   the ubuntu base image is rebuilt too seldom sometimes (less than once a month)
    apt-get upgrade --yes && \
    apt install --yes --no-install-recommends\
    git\
    wget\
    curl\
    vim\
    bash\
    libgl1\
    software-properties-common\
    openssh-server
RUN add-apt-repository ppa:deadsnakes/ppa
RUN apt install --yes --no-install-recommends\
  python3.10\
  python3.10-dev\
  python3.10-venv && \
	ln -s /usr/bin/python3.10 /usr/bin/python && \
	rm /usr/bin/python3 && \
	ln -s /usr/bin/python3.10 /usr/bin/python3
RUN curl https://bootstrap.pypa.io/get-pip.py -o get-pip.py
RUN python get-pip.py
RUN pip install -U jupyterlab ipywidgets jupyter-archive
RUN jupyter nbextension enable --py widgetsnbextension

RUN apt-get clean && rm -rf /var/lib/apt/lists/* && \
    echo "en_US.UTF-8 UTF-8" > /etc/locale.gen

ADD start.sh /
RUN chmod +x /start.sh
COPY kernel.json /usr/local/share/jupyter/kernels/python3/kernel.json

RUN mkdir -p /transformers/venv /transformers/hf_model_cache /transformers/hf_dataset_cache && \
    python -m venv --system-site-packages --symlinks /transformers/venv && \
    source /transformers/venv/bin/activate && \
    pip install torch==2.0.0 torchvision==1.51 torchaudio==2.0.0

ENV TRANSFORMERS_CACHE=/transformers/hf_model_cache
ENV HF_DATASETS_CACHE=/transformers/hf_dataset_cache
WORKDIR /transformers

CMD [ "/start.sh" ]
