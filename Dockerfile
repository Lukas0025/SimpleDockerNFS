FROM alpine:latest

RUN apk --update --no-cache add bash sh nfs-utils && \\
    rm -v /etc/idmapd.conf /etc/exports


RUN mkdir -p /var/lib/nfs/rpc_pipefs                                                     && \
    mkdir -p /var/lib/nfs/v4recovery                                                     && \
    mkdir /nfs                                                                           && \
    echo "rpc_pipefs  /var/lib/nfs/rpc_pipefs  rpc_pipefs  defaults  0  0" >> /etc/fstab && \
    echo "nfsd        /proc/fs/nfsd            nfsd        defaults  0  0" >> /etc/fstab

# setup entrypoint
COPY exports /etc/exports
COPY entrypoint.sh /usr/local/bin

ENTRYPOINT ["/usr/local/bin/entrypoint.sh"]
