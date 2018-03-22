FROM alpine:3.6
LABEL maintainer="dat.tran@idealo.de"

# Install miniconda
RUN apk --update --repository http://dl-4.alpinelinux.org/alpine/edge/community add \
    bash \
    git \
    curl \
    ca-certificates \
    bzip2 \
    unzip \
    sudo \
    libstdc++ \
    glib \
    libxext \
    libxrender \
    tini \
    && curl -L "https://github.com/andyshinn/alpine-pkg-glibc/releases/download/2.25-r0/glibc-2.25-r0.apk" -o /tmp/glibc.apk \
    && curl -L "https://github.com/andyshinn/alpine-pkg-glibc/releases/download/2.25-r0/glibc-bin-2.25-r0.apk" -o /tmp/glibc-bin.apk \
    && curl -L "https://github.com/andyshinn/alpine-pkg-glibc/releases/download/2.25-r0/glibc-i18n-2.25-r0.apk" -o /tmp/glibc-i18n.apk \
    && apk add --allow-untrusted /tmp/glibc*.apk \
    && /usr/glibc-compat/sbin/ldconfig /lib /usr/glibc-compat/lib \
    && /usr/glibc-compat/bin/localedef -i en_US -f UTF-8 en_US.UTF-8 \
    && rm -rf /tmp/glibc*apk /var/cache/apk/*

RUN echo 'export PATH=/opt/conda/bin:$PATH' > /etc/profile.d/conda.sh && \
    curl https://repo.continuum.io/miniconda/Miniconda3-4.3.27-Linux-x86_64.sh -o ~/miniconda.sh && \
    /bin/bash ~/miniconda.sh -f -b -p /opt/conda && \
    rm ~/miniconda.sh

ENV PATH /opt/conda/bin:$PATH

# Install dependencies via Anaconda
RUN mkdir -p /deploy/app
COPY app/requirements.txt /deploy/app/requirements.txt
RUN conda install -y --file /deploy/app/requirements.txt

# Deploy application
COPY gunicorn_config.py /deploy/gunicorn_config.py
COPY app /deploy/app
WORKDIR /deploy/app

# Set Python path
ENV PYTHONPATH=/deploy

EXPOSE 8080

CMD ["gunicorn", "--config", "/deploy/gunicorn_config.py", "main:app"]
