# Docker image with gcloud-kubectl-helm

This docker image is designed to bootstrap the configuration of 3 CLI tools gcloud, kubectl and helm which are essential for the management of a Kubernetes cluster on GKE (Google Container Engine).

To authenticate towards the services you may either re-build the image redefining the environment variables available in the Dockerfile or pass all the values at runtime.

> NOTE: you may reuse the available sample files: `example/gcp-cluster.env`, `example/gcp-credentials.json`

```bash
$ cp -f example/* gcp/
```

## sample usage (runtime):

```bash
$ docker run -it \
--volume $(pwd)/gcp:/gcp \
--env-file gcp/gcp-cluster.env \
lfaoro/gcloud-kubectl-helm
```

## Updates

This image auto-builds every day using the latest releases supplied by the tool vendor.

This image won't maintain multiple versions for backward compatibility, you should keep up to date with the latest release or re-build the image yourself to suit your needs.

The only available tag is `latest`

## Usecases

I heavily use this image for CI/CD operations passing the various cluster credentials contained in Hashicorp's Vault or the CI secrets vault at runtime.

Another sporadic usecase is to have available all commands at once on a CoreOS system rather than switching between containers to run the commands.

## Copyright

Please push back to the repo any improvements or added functionality.
