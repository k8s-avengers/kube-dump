FROM alpine:3

ARG KUBECTL_VERSION="1.30.6"
ARG TARGETARCH

RUN apk add --update --no-cache bash jq tar gzip curl coreutils grep age

RUN set  -x && ARCH=$(echo $TARGETARCH) && \
    URL="https://dl.k8s.io/release/v${KUBECTL_VERSION}/bin/linux/$ARCH/kubectl" && \
    echo "Downloading for ARCH: $ARCH via URL: $URL" && \
    curl -Lo /usr/bin/kubectl "${URL}" && \
    chmod +x /usr/bin/kubectl

RUN kubectl version --client

COPY ./kube-dump /kube-dump

ENTRYPOINT [ "/kube-dump" ]
