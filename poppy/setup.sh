# This is the installer for the web wifi configuration


if [ `whoami` != "root" ];
then
    echo "You must run the app as root:"
    echo "sudo bash $0"
    exit 0
fi

# Install needed apps
apt-get update
apt-get -y install apache2 php5 libapache2-mod-php5 network-manager \
avahi-daemon libnss-mdns subversion

# Sudo configuration for the websudoer app
echo "www-data ALL=(ALL) NOPASSWD: /usr/local/robot/websudoer/websudoer.sh" >> /etc/sudoers

# Apache configuration
if ! grep -q added /etc/apache2/sites-enabled/000-default.conf
then
    sed -i.bkp '/VirtualHost>/i #added lines\n\t<Directory \/web\/>\n\t\tOrder deny,allow\n\t\tAllow from all\n\t</Directory>' /etc/apache2/sites-enabled/000-default.conf
    sed -i 's/\/var\/www\/html/\/var\/www\/web/g' /etc/apache2/sites-enabled/000-default.conf
fi

# Add scripts
mkdir /usr/local/robot
mkdir /usr/local/robot/websudoer
rm /usr/local/robot/websudoer/websudoer.sh
mkdir /var/www/web

# Download sources
wget -P  /usr/local/robot/websudoer https://raw.githubusercontent.com/MakingBot/webapp/master/websudoer/websudoer.sh
chmod +x /usr/local/robot/websudoer/websudoer.sh
svn checkout https://github.com/MakingBot/webapp/trunk/web /var/www/web

echo Please reboot to apply changes
