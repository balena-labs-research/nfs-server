## NFS Server

This container exposes the content of a volume for mounting to your local system. Ideal for developing locally while testing on device.

### Starting the server

Add the following to your docker-compose file to share a volume called `nfs`:

```
version: "2"

services:
  nfs:
    image: bh.cr/maggie0002/nfs-server
    volumes:
      - "nfs:/nfs"
    restart: always
    network_mode: host
    privileged: true
    labels:
      io.balena.features.kernel-modules: "1"
      io.balena.features.sysfs: "1"
      io.balena.features.procfs: "1"

    # If content from your primary image is required in the volume ensure this container depends
    # on the primary image. This will ensure your primary container creates the volume and inserts
    # your content.

    # depends_on:
    #  - name_of_primary_container

volumes:
  nfs:
```

If you already have services running, you can start this container manually. Connect to your device with SSH then run:

```
balena run -it --privileged --network host -v /lib/modules:/lib/modules -v /sys/fs:/sys/fs -v nfs:/nfs bh.cr/maggie0002/nfs-server
```

### Accessing the server

Once running, on your Mac you can run the following to make the volume accessible on your system:

`mount_nfs hostname.local:/nfs ./local_dir`

# Acknowledgements

Credit to the [balena-nfs block](https://hub.balena.io/organizations/volkovlabs/apps/balena-nfs) creators for finding this efficient mode of running NFS on balena.
