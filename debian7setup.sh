apt-get update; apt-get upgrade -y;
apt-get -y install vim htop cron zip unzip wget curl mc sudo apache2-utils
update-alternatives --set editor /usr/bin/vim.basic
locale-gen "ru_RU.UTF-8"
sed -i -e 's/# en_US.UTF-8 UTF-8/en_US.UTF-8 UTF-8/' /etc/locale.gen && \
sed -i -e 's/# ru_RU.UTF-8 UTF-8/ru_RU.UTF-8 UTF-8/' /etc/locale.gen && \
echo 'LANG="ru_RU.UTF-8"'>/etc/default/locale && \
dpkg-reconfigure --frontend=noninteractive locales && \
update-locale LANG=ru_RU.UTF-8
echo "Europe/Kiev" > /etc/timezone && \
dpkg-reconfigure -f noninteractive tzdata

sed -i -e 's/"syntax on/syntax on\ncolorscheme ron\nset number/' /etc/vim/vimrc
echo "PS1='${debian_chroot:+($debian_chroot)}\[\033[01;32m\]\u@\h\[\033[00m\]:\[\033[01;34m\]\w\[\033[00m\]\$ '" >> ~/.bashrc

apt-get -y install bsdutils build-essential libaio1 libssl-dev libcurl4-openssl-dev libevent-dev sendmail-bin sensible-mda
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
