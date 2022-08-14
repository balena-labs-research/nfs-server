FROM alpine:3.16

## Environment
ENV UDEV=1

## NFS Server
RUN apk add nfs-utils openrc --no-cache
RUN rc-update add nfs

# Set required permissions for the mount
RUN echo "/nfs *(rw,sync,no_subtree_check,no_auth_nlm,insecure,all_squash,anonuid=0,anongid=0,fsid=root)" > /etc/exports

## Entrypoint
COPY entrypoint.sh /entrypoint.sh
RUN chmod +x /entrypoint.sh
ENTRYPOINT ["/entrypoint.sh"]

CMD ["tail", "-f", "/dev/null"]
