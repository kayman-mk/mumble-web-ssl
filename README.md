# Installation
1. Open the `.env` file and replace the variables by an appropriate value
2. Open the `mumble-server/murmur.ini` file and configure the Mumble server. Make sure
to enable the lines `sslCert` and `sslKey`. The values will be set by `install.sh` later.
3. Run `bash install.sh` to install the required software and launch Mumble.
4. Make sure that no errors are shown in the Docker logs.
5. In the `.env` file: Set `LETSENCRYPT_STAGING=0` to get a real certificate. Append
a `-0001` to the `CERTIFICATE_DIRECTORY`.
6. Run `docker compose up -d` to fetch the Letsencrypt certificate for the domain.
7. As soon as the certificate is present (check docker logs), do a
   `docker compose down && docker compose up -d` to refresh all containers.

# Parameters
Parameters are stored in the `.env` file.

## EXTERNAL_HOST_NAME
The full qualified host name used to reach the Mumble server, e.g. mumble.my-domain.de

## CERTIFICATE_DIRECTORY
The name of the Letsencrypt directory holding the certificates. Should be set to the
`EXTERNAL_HOST_NAME`. But as soon as `LETSENCRYPT_STAGING=0` is set, append a `-0001`
to it, e.g. `CERTIFICATE_DIRECTORY="mumble.my-domain.de-0001"`.

## LETSENCRYPT_EMAIL
Email address to use to create the Letsencrypt account.

## LETSENCRYPT_STAGING
Set to `1` to use the staging environment for testing purposes. `0` creates real
certificates which are accepted by all major browsers.

# Thanks
* [vimagick/murmur](https://github.com/vimagick/dockerfiles) for the Mumble server image
* [rankenstein/mumble-web](https://github.com/rankenstein/mumble-web) for the Mumble web interface
* [vdhpieter/letsencrypt-webroot](https://github.com/vdhpieter/docker-letsencrypt-webroot) for the Letsencrypt implementation
