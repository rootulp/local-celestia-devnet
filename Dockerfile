# The celestia-app version used here should match the version specified in the
# celestia-node's go.mod.
FROM ghcr.io/celestiaorg/celestia-app:v1.0.0-rc14 AS celestia-app
FROM ghcr.io/celestiaorg/celestia-node:v0.11.0-rc13

USER root

# hadolint ignore=DL3018
RUN apk --no-cache add \
    curl \
    jq \
    file \
    linux-headers\
    && mkdir /bridge \
    && chown celestia:celestia /bridge

USER celestia

COPY --chown=celestia --from=celestia-app /bin/celestia-appd /bin/

COPY entrypoint.sh /opt/entrypoint.sh

EXPOSE 26657 26658 26659 9090

ENTRYPOINT [ "/bin/bash", "/opt/entrypoint.sh" ]
