FROM registry.access.redhat.com/ubi9/ubi:9.8

ARG OC_MIRROR_VERSION=latest

RUN dnf -y install tar && \
    dnf clean all && \
    rm -rf /var/cache/dnf && \
    curl -fL \
      "https://mirror.openshift.com/pub/openshift-v4/clients/ocp/${OC_MIRROR_VERSION}/oc-mirror.tar.gz" \
      -o /tmp/oc-mirror.tar.gz && \
    tar -xzf /tmp/oc-mirror.tar.gz -C /usr/local/bin/ && \
    chmod +x /usr/local/bin/oc-mirror && \
    rm -f /tmp/oc-mirror.tar.gz

LABEL name="dcm-oc-mirror" \
      version="latest" \
      description="oc-mirror disconnected registry mirroring tool" \
      maintainer="heatmiser"

ENTRYPOINT ["/usr/local/bin/oc-mirror"]
