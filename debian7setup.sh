apt-get update; apt-get upgrade -y;
apt-get -y install vim htop cron zip unzip wget curl mc apache2-utils
update-alternatives --set editor /usr/bin/vim.basic
locale-gen "ru_RU.UTF-8"
export LANGUAGE=ru_RU.UTF-8 && \
	export LANG=ru_RU.UTF-8 && \
	export LC_ALL=ru_RU.UTF-8 && \
	locale-gen ru_RU.UTF-8 && \
	--frontend=noninteractive dpkg-reconfigure locales
echo "Europe/Kiev" > /etc/timezone && \
dpkg-reconfigure -f noninteractive tzdata


apt-get -y install module-init-tools
apt-get -y install php5-cli php-pear php5-curl php5-gd php5-mcrypt php5-dev php5-intl php5-fpm memcached php5-memcached php5-xsl imagemagick php5-imagick
sed -i 's/\;date\.timezone\ \=/date\.timezone\ \=\ Europe\/Kiev/g' /etc/php5/cli/php.ini
sed -i 's/\;date\.timezone\ \=/date\.timezone\ \=\ Europe\/Kiev/g' /etc/php5/fpm/php.ini
sed -i "s/max_execution_time = .*/max_execution_time = 60/" /etc/php5/fpm/php.ini
sed -i "s/upload_max_filesize = .*/upload_max_filesize = 32M/" /etc/php5/fpm/php.ini
sed -i "s/post_max_size = .*/post_max_size = 32M/" /etc/php5/fpm/php.ini
sed -i "s/short_open_tag = .*/short_open_tag = On/" /etc/php5/fpm/php.ini
sed -i "s/short_open_tag = .*/short_open_tag = On/" /etc/php5/cli/php.ini
sed -i -e "s/;cgi.fix_pathinfo=1/cgi.fix_pathinfo=0/g" /etc/php5/fpm/php.ini
sed -i "s/;opcache.enable=0/opcache.enable=0/" /etc/php5/fpm/php.ini

curl -sS https://getcomposer.org/installer | php && \
mv composer.phar /usr/local/bin/composer
