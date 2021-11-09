#!/bin/bash
set -euo pipefail

sed -i "s/{{PROXY_SERVICE}}/${PROXY_SERVICE}/g;" /etc/nginx/nginx.conf
sed -i "s/{{SERVER_NAME}}/${SERVER_NAME}/g;" /etc/nginx/nginx.conf
sed -i "s/{{CERTIFICATE_DIRECTORY}}/${CERTIFICATE_DIRECTORY}/g;" /etc/nginx/nginx.conf

echo "Running Nginx ..."
nginx -g 'daemon off;'
