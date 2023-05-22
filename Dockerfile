FROM ubuntu:latest
LABEL maintainer="weam@gmail.com"
ENV TZ=Africa/Cairo
RUN ln -snf /usr/share/zoneinfo/$TZ /etc/localtime && echo $TZ > /etc/timezone
RUN apt update
RUN apt install  openssh-server ssh iputils-ping unzip wget apache2 curl software-properties-common -y
RUN add-apt-repository ppa:ondrej/php
RUN apt update -y
RUN apt install php7.4 php7.4-mbstring php7.4-mysql php7.4-curl php7.4-json php7.4-xsl -y
RUN a2enmod rewrite
RUN sed -i -e "s/post_max_size.*/post_max_size = 50M/g" -e "s/upload_max_filesize.*/upload_max_filesize = 15M/g" /etc/php/7.4/apache2/php.ini
COPY index.php /var/www/html
CMD ["/usr/sbin/apache2ctl", "-DFOREGROUND"]
