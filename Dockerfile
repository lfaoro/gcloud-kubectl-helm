FROM docker:latest

ENV KEYFILE=example/gcp-credentials.json
ENV PROJECT=
ENV ZONE=
ENV CLUSTER=
ENV SERVICE_ACCOUNT=

WORKDIR /root

# System
RUN apk update && apk add --no-cache --virtual .build-deps \
    ca-certificates \
    curl \
    tar \
    bash \
    openssl \
    python \
    git

# GCloud SDK
RUN curl -OL https://dl.google.com/dl/cloudsdk/channels/rapid/install_google_cloud_sdk.bash && \
    bash install_google_cloud_sdk.bash --disable-prompts --install-dir='/root/' && \
    ln -s /root/google-cloud-sdk/bin/gcloud /usr/local/bin/gcloud

# Kubectl
RUN curl -LO https://storage.googleapis.com/kubernetes-release/release/$(curl -s https://storage.googleapis.com/kubernetes-release/release/stable.txt)/bin/linux/amd64/kubectl && \
    chmod +x ./kubectl && \
    mv ./kubectl /usr/local/bin/kubectl

# Helm
RUN curl https://raw.githubusercontent.com/kubernetes/helm/master/scripts/get | bash

# Authenticate
RUN mkdir -p /gcp
COPY authenticate.bash /root/authenticate.bash
COPY $KEYFILE /gcp/gcp-credentials.json

CMD ["/bin/bash"]
