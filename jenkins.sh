#!/bin/sh
#Jenkins host
JENKINS_HOST=jenkins.localhost
wget -q -O - http://pkg.jenkins-ci.org/debian/jenkins-ci.org.key | apt-key add -
echo "deb http://pkg.jenkins-ci.org/debian binary/" >> /etc/apt/sources.list.d/jenkins.list
apt-get update
apt-get install jenkins
wget http://localhost:8080/jnlpJars/jenkins-cli.jar
java -jar jenkins-cli.jar -s http://localhost:8080 install-plugin checkstyle cloverphp crap4j dry htmlpublisher jdepend plot pmd violations warnings xunit
java -jar jenkins-cli.jar -s http://localhost:8080 safe-restart
apt-get -y install xvfb gtk2-engines-pixbuf
apt-get -y install xfonts-base xfonts-75dpi xfonts-100dpi
apt-get -y install xfonts-scalable xfonts-cyrillic
apt-get -y install x11-apps imagemagick
apt-get -y install ttf-liberation
apt-get -y install x-window-system-core
wget -q -O - https://dl-ssl.google.com/linux/linux_signing_key.pub | apt-key add -
echo "deb http://dl.google.com/linux/chrome/deb/ stable main" >> /etc/apt/sources.list.d/google-chrome.list
cat /etc/apt/sources.list.d/google-chrome.list
apt-get update && apt-get upgrade
apt-get install -y xfonts-100dpi xfonts-75dpi xfonts-scalable xfonts-cyrillic xvfb x11-apps
apt-get -y install google-chrome-stable
wget http://chromedriver.storage.googleapis.com/2.20/chromedriver_linux64.zip
unzip chromedriver_linux64.zip
mv chromedriver /usr/local/bin/chromedriver
rm chromedriver_linux64.zip
