FROM nginx:1.29.1

# add configuration
ADD nginx.conf /etc/nginx/

ADD entrypoint.sh /
RUN chmod +x /entrypoint.sh

HEALTHCHECK --interval=30s --start-period=10s CMD curl -fso /dev/null http://127.0.0.1

# fix configuration and start Nginx
ENTRYPOINT /entrypoint.sh
