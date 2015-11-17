#Debian 8 setup:
cd /opt <br />
wget https://raw.githubusercontent.com/antonchernik/lnmp-debian/master/debian8setup.sh <br />
chmod +x /opt/debian8setup.sh <br />
./debian8setup.sh


#Jenkins setup:
##Can be executed only after *setup.sh executed successfully
cd /opt <br />
wget https://raw.githubusercontent.com/antonchernik/lnmp-debian/master/jenkins.sh <br />
chmod +x /opt/jenkins.sh <br />
./jenkins.sh

