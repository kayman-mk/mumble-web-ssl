FROM nginx:1.21.3

# add configuration
ADD nginx.conf /etc/nginx/

ADD entrypoint.sh /
RUN chmod +x /entrypoint.sh

# fix configuration and start Nginx
ENTRYPOINT /entrypoint.sh
