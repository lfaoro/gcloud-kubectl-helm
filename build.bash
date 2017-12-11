#!/usr/bin/env bash

docker build -t lfaoro/gcloud-kubectl-helm:latest . && \
docker push lfaoro/gcloud-kubectl-helm:latest
