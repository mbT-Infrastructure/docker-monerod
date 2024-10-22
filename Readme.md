# monerod image

This image contains a monerod install. It only allows restricted RPC connections.

## Installation

1. Pull from [Docker Hub], download the package from [Releases] or build using `builder/build.sh`

## Usage

This Container image extends the [base image].

### Environment variables

-   `BATCH_SIZE`
    -   How many blocks are processed in a single batch during chain synchronization, default: `10`.
- `PROXY_URL`
    - Run network communication through specified proxy.
- `PRUNE_BLOCKCHAIN`
    - Remove non-critical blockchain information from the local blockchain.

### Volumes

-   `/media/monerod`
    -   The data directory for monerod.

## Development

To run for development execute:

```bash
docker compose --file docker-compose-dev.yaml up --build
```

[base image]: https://github.com/mbT-Infrastructure/docker-base
[Docker Hub]: https://hub.docker.com/r/madebytimo/monerod
[Releases]: https://github.com/mbT-Infrastructure/docker-monerod/releases
