FROM madebytimo/builder AS builder

ARG TARGETPLATFORM

WORKDIR /root/builder

RUN download.sh https://raw.githubusercontent.com/monero-project/monero/refs/heads/master/utils/\
gpg_keys/binaryfate.asc https://www.getmonero.org/downloads/hashes.txt \
    && gpg --keyring ./signature-public-keys.gpg --no-default-keyring --import binaryfate.asc \
    && rm binaryfate.asc \
    && gpg --keyring ./signature-public-keys.gpg --no-default-keyring --quiet \
    --verify hashes.txt \
    && rm signature-public-keys.gpg* \
    && download.sh $(curl --head --location --output /dev/null --silent --write-out \
        '%{url_effective}' https://downloads.getmonero.org/cli/$(echo "$TARGETPLATFORM" | \
        sed --expression 's|/amd||' --expression 's|/arm64|arm8|')) \
    && sha256sum --ignore-missing --check hashes.txt \
    && rm hashes.txt \
    && compress.sh --decompress monero-*.tar.bz2 \
    && mv monero-*/monerod  monero-*/LICENSE . \
    && rm -r monero-*

FROM madebytimo/base

WORKDIR /opt/monero
COPY --from=builder /root/builder/* .
COPY files/entrypoint.sh files/healthcheck.sh files/run.sh /usr/local/bin/

ENV PROXY_URL=""
ENV PRUNE_BLOCKCHAIN="false"

WORKDIR /
ENTRYPOINT [ "entrypoint.sh" ]
CMD [ "run.sh" ]

HEALTHCHECK CMD [ "healthcheck.sh" ]

LABEL org.opencontainers.image.licenses="MIT"
LABEL org.opencontainers.image.source="https://github.com/mbt-infrastructure/docker-monerod"
