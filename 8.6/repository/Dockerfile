FROM centos:7

EXPOSE 5290 5290

ENV PYTHON_VERSION=3.7.17

COPY requirements.txt /tmp/

RUN yum -y install wget make gcc openssl-devel bzip2-devel libffi-devel && \
    wget https://www.python.org/ftp/python/${PYTHON_VERSION}/Python-${PYTHON_VERSION}.tgz && \
    tar -xzf Python-${PYTHON_VERSION}.tgz && \
    rm Python-${PYTHON_VERSION}.tgz && \
    yum clean all && rm -rf /var/cache/yum/*

WORKDIR /Python-${PYTHON_VERSION}

RUN ./configure --enable-optimizations && make -j8 altinstall && \
    ln -sf /usr/local/bin/python3.7 /usr/bin/python3 && \
    cd  && rm -rf /Python-${PYTHON_VERSION}

ENV PIP_ROOT_USER_ACTION=ignore
RUN pip3.7 install --upgrade pip && \
    python3 -m pip install --root-user-action=ignore -r /tmp/requirements.txt

ADD python-api.py /python_api/python-api.py

CMD ["python3", "/python_api/python-api.py"]
