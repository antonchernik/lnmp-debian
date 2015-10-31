#!/bin/sh
#Debian user
USER=user
#Debian user group
GROUP=user
#Debian user password
PASSWORD=access
#Mysql root password
MYSQL_ROOT_PASSWORD=access
#If user does not exists create it
id -u $USER &>/dev/null || adduser $USER --disabled-password --gecos "" && echo "$USER:$PASSWORD" | chpasswd
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
echo "PS1='${debian_chroot:+($debian_chroot)}\[\033[01;31m\]\u\[\033[01;33m\]@\[\033[01;36m\]\h \[\033[01;33m\]\w \[\033[01;35m\]\$ \[\033[00m\]'" >> ~/.bashrc

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
sed -i -e 's/-m 64/-m 256/' /etc/memcached.conf
/etc/init.d/memcached restart


curl -sS https://getcomposer.org/installer | php && \
mv composer.phar /usr/local/bin/composer

cp /etc/php5/fpm/pool.d/www.conf /etc/php5/fpm/pool.d/php.conf
mv /etc/php5/fpm/pool.d/www.conf /etc/php5/fpm/pool.d/www.conf.old

sed -i "s/\[www\]/\[php\]/g" /etc/php5/fpm/pool.d/php.conf
sed -i -e "s/.*listen =.*/listen = \/var\/run\/php-fpm.sock/" /etc/php5/fpm/pool.d/php.conf
sed -i -e "s/pm.max_children = 5/pm.max_children = 9/g" /etc/php5/fpm/pool.d/php.conf
sed -i -e "s/pm.start_servers = 2/pm.start_servers = 3/g" /etc/php5/fpm/pool.d/php.conf
sed -i -e "s/pm.min_spare_servers = 1/pm.min_spare_servers = 2/g" /etc/php5/fpm/pool.d/php.conf
sed -i -e "s/pm.max_spare_servers = 3/pm.max_spare_servers = 4/g" /etc/php5/fpm/pool.d/php.conf
sed -i -e "s/pm.max_requests = 500/pm.max_requests = 200/g" /etc/php5/fpm/pool.d/php.conf
sed -i -e "s/user = www-data/user = $USER/g" /etc/php5/fpm/pool.d/php.conf
sed -i -e "s/group = www-data/group = $GROUP/g" /etc/php5/fpm/pool.d/php.conf
sed -i -e "s/listen.group = user/listen.group = www-data/g" /etc/php5/fpm/pool.d/php.conf
sed -i -e "s/;listen.mode = 0660/listen.mode = 0750/g" /etc/php5/fpm/pool.d/php.conf

apt-get -y install imagemagick php5-imagick
apt-get -y install sendmail-bin sensible-mda
apt-get -y install gcc g++ libboost-dev libboost-program-options-dev
apt-get -y install gearman-job-server libgearman-dev
pecl install gearman
echo "extension=gearman.so" | tee /etc/php5/mods-available/gearman.ini
ln -s /etc/php5/mods-available/gearman.ini /etc/php5/cli/conf.d/20-gearman.ini
ln -s /etc/php5/mods-available/gearman.ini /etc/php5/fpm/conf.d/20-gearman.ini
/etc/init.d/gearman-job-server restart
/etc/init.d/php5-fpm restart

echo "deb-src http://repo.mysql.com/apt/debian/ jessie mysql-5.7" >> /etc/apt/sources.list.d/mysql.list
echo "deb http://repo.mysql.com/apt/debian/ jessie mysql-5.7"  >> /etc/apt/sources.list.d/mysql.list
apt-get update; apt-get upgrade -y;

echo "mysql-server mysql-server/root_password password $MYSQL_ROOT_PASSWORD" | debconf-set-selections 
echo "mysql-server mysql-server/root_password_again password $MYSQL_ROOT_PASSWORD" | debconf-set-selections 
apt-get -y install mysql-server

apt-key adv --keyserver keyserver.ubuntu.com --recv 7F0CEB10
echo "deb http://repo.mongodb.org/apt/debian wheezy/mongodb-org/3.0 main" | tee /etc/apt/sources.list.d/mongodb-org-3.0.list
apt-get update; apt-get upgrade -y;
apt-get install -y mongodb-org
service mongod start
pecl install mongo
echo "extension=mongo.so" | tee /etc/php5/mods-available/mongo.ini
ln -s /etc/php5/mods-available/mongo.ini /etc/php5/cli/conf.d/20-mongo.ini
ln -s /etc/php5/mods-available/mongo.ini /etc/php5/fpm/conf.d/20-mongo.ini

echo "deb http://www.deb-multimedia.org wheezy main non-free" >> /etc/apt/sources.list.d/deb-multimedia.list && \
echo "deb-src http://www.deb-multimedia.org wheezy main non-free" >> /etc/apt/sources.list.d/deb-multimedia.list && \
apt-get update && \
apt-get install deb-multimedia-keyring



