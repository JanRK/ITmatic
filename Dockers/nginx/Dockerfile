FROM debian:jessie

minimal_apt_get_args='-y --no-install-recommends'
nginx_PACKAGES="curl wget ca-certificates"
nginx_PACKAGES="$nginx_PACKAGES ca-certificates"


RUN apt-get update -y && apt-get install $minimal_apt_get_args $nginx_PACKAGES

RUN \
  wget -O - http://nginx.org/keys/nginx_signing.key | apt-key add - && \
  sh -c "echo 'deb http://nginx.org/packages/debian/ jessie nginx' >> /etc/apt/sources.list.d/nginx.list" && \
  sh -c "echo 'deb-src http://nginx.org/packages/debian/ jessie nginx' >> /etc/apt/sources.list.d/nginx.list" && \

  
  apt-get update && \
  apt-get install -y nginx && \
  rm -rf /var/lib/apt/lists/* && \
  echo "\ndaemon off;" >> /etc/nginx/nginx.conf && \
  mkdir /var/lib/nginx && \
  chown -R www-data:www-data /var/lib/nginx && \
  AUTO_ADDED_PACKAGES=`apt-mark showauto` && \
  apt-get remove --purge -y $AUTO_ADDED_PACKAGES


# Define mountable directories.
VOLUME ["/etc/nginx/sites-enabled", "/etc/nginx/certs", "/etc/nginx/conf.d", "/var/log/nginx", "/var/www/html"]

# Define working directory.
WORKDIR /etc/nginx

# Define default command.
CMD ["nginx"]

# Expose ports.
EXPOSE 80
EXPOSE 443
