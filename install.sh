#!env bash
set -euo pipefail

# install Docker
sudo apt-get update
sudo apt-get install -y ca-certificates curl gnupg lsb-release

curl -fsSL https://download.docker.com/linux/ubuntu/gpg | sudo gpg --dearmor -o /usr/share/keyrings/docker-archive-keyring.gpg
echo \
  "deb [arch=$(dpkg --print-architecture) signed-by=/usr/share/keyrings/docker-archive-keyring.gpg] https://download.docker.com/linux/ubuntu \
  $(lsb_release -cs) stable" | sudo tee /etc/apt/sources.list.d/docker.list > /dev/null

sudo apt-get update
sudo apt-get install -y docker-ce docker-ce-cli containerd.io

# install Docker Compose
if [ ! -f /usr/local/bin/docker-compose ]; then
  sudo curl -L "https://github.com/docker/compose/releases/download/1.29.2/docker-compose-$(uname -s)-$(uname -m)" -o /usr/local/bin/docker-compose
  sudo chmod +x /usr/local/bin/docker-compose
fi

if [ ! -d letsencrypt ]; then
  mkdir -p letsencrypt/{conf,html}
  # to be able to store the initially created self signed certificate
  mkdir -p letsencrypt/conf/live/${EXTERNAL_HOST_NAME}
fi

if [ ! -d mumble-server-data ]; then
  mkdir mumble-server-data
fi

# generate DH Params for Nginx
if [ ! -f nginx/dhparams.pem ]; then
  openssl dhparam -out nginx/dhparams.pem 2048
fi

# adjust the certificate path for mumble server
SSL_CERTIFICATE_FILE="\\/etc\\/letsencrypt\\/live\\/${CERTIFICATE_DIRECTORY}\\/fullchain.pem"
SSL_PRIVATE_KEY_FILE="\\/etc\\/letsencrypt\\/live\\/${CERTIFICATE_DIRECTORY}\\/privkey.pem"

sed -i "s/^sslCert=.*/sslCert=${SSL_CERTIFICATE_FILE}/" mumble-server/murmur.ini
sed -i "s/^sslKey=.*/sslKey=${SSL_PRIVATE_KEY_FILE}/" mumble-server/murmur.ini

docker-compose up -d
