apt-get install vim htop cron zip unzip wget curl mc apache2-utils
update-alternatives --set editor /usr/bin/vim.basic
locale-gen "ru_RU.UTF-8"
export LANGUAGE=en_US.UTF-8 && \
	export LANG=en_US.UTF-8 && \
	export LC_ALL=en_US.UTF-8 && \
	locale-gen en_US.UTF-8 && \
	--frontend=noninteractive dpkg-reconfigure locales
echo "Europe/Kiev" > /etc/timezone && \
dpkg-reconfigure -f noninteractive tzdata
