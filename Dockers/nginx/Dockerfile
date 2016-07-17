FROM debian:jessie

RUN apt-get update && apt-get -y install curl wget

RUN \
  wget -O - http://nginx.org/keys/nginx_signing.key | apt-key add - && \
  sh -c "echo 'deb http://nginx.org/packages/debian/ jessie nginx' >> /etc/apt/sources.list.d/nginx.list" && \
  sh -c "echo 'deb-src http://nginx.org/packages/debian/ jessie nginx' >> /etc/apt/sources.list.d/nginx.list" && \

  
  apt-get update && \
  apt-get install -y nginx && \
  rm -rf /var/lib/apt/lists/* && \
  echo "\ndaemon off;" >> /etc/nginx/nginx.conf && \
  mkdir /var/lib/nginx && \
  chown -R www-data:www-data /var/lib/nginx

# Define mountable directories.
VOLUME ["/etc/nginx/sites-enabled", "/etc/nginx/certs", "/etc/nginx/conf.d", "/var/log/nginx", "/var/www/html"]

# Define working directory.
WORKDIR /etc/nginx

# Define default command.
CMD ["nginx"]

# Expose ports.
EXPOSE 80
EXPOSE 443
