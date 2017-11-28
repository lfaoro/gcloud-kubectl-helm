FROM docker:latest

ENV SERVICE_ACCOUNT psp-test-cluster@akce-psp-v1.iam.gserviceaccount.com
ENV KEYFILE gcp-credentials.json

WORKDIR /root/

RUN apk update && apk add --no-cache --virtual .build-deps \
    ca-certificates \
    curl \
    tar \
    bash \
    openssl \
    python

# GCloud SDK
RUN curl -OL https://dl.google.com/dl/cloudsdk/channels/rapid/install_google_cloud_sdk.bash && \
    bash install_google_cloud_sdk.bash --disable-prompts --install-dir='/root/' && \
    ln -s /root/google-cloud-sdk/bin/gcloud /usr/local/bin/gcloud && \
    gcloud components install docker-credential-gcr && \
    ln -s /root/google-cloud-sdk/bin/docker-credential-gcr /usr/local/bin/docker-credential-gcr


# Kubectl
RUN curl -LO https://storage.googleapis.com/kubernetes-release/release/$(curl -s https://storage.googleapis.com/kubernetes-release/release/stable.txt)/bin/linux/amd64/kubectl && \
    chmod +x ./kubectl && \
    mv ./kubectl /usr/local/bin/kubectl

# Helm
RUN curl https://raw.githubusercontent.com/kubernetes/helm/master/scripts/get | bash

# Authenticate
COPY $KEYFILE /tmp/gcp-credentials.json
RUN gcloud auth activate-service-account $SERVICE_ACCOUNT --key-file=/tmp/gcp-credentials.json && \
    gcloud container clusters get-credentials psp-test-cluster --zone europe-west1-b --project akce-psp-v1 && \
    docker-credential-gcr configure-docker

ENTRYPOINT [ "/bin/bash" ]
