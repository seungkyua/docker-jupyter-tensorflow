FROM ubuntu:16.04

MAINTAINER Seungkyu Ahn <seungkyua@gmail.com>

ENV DEBIAN_FRONTEND=noninteractive

RUN sed -i 's/archive.ubuntu.com/kr.archive.ubuntu.com/g' /etc/apt/sources.list

RUN apt-get update && \
       apt-get install -yq --no-install-recommends \
             build-essential \
             python-dev \
             ca-certificates \
             locales \
             wget \
             bzip2 \
             python-pip \
             python-setuptools \
             fonts-liberation && \
       apt-get clean  && \
    rm -rf /var/lib/apt/lists/* /tmp/* /var/tmp/*

RUN echo "en_US.UTF-8 UTF-8" > /etc/locale.gen && locale-gen

RUN pip install --upgrade pip
RUN pip install --upgrade tensorflow
RUN pip install ipykernel \
           ipython \
           matplotlib \
           jupyter

RUN mkdir -p -m 700 /root/.jupyter/
ADD jupyter_notebook_config.py /root/.jupyter/

EXPOSE 8888

ENTRYPOINT ["jupyter"]
CMD ["notebook", "--allow-root" "--ip", "0.0.0.0"]
