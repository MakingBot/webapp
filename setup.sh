# This is the installer for the web wifi configuration


if [ `whoami` != "root" ];
then
    echo "You must run the app as root:"
    echo "sudo bash $0"
    exit 0
fi

# Install needed apps
apt-get -y install apache2 php5 libapache2-mod-php5 network-manager \
avahi-daemon libnss-mdns

# Sudo configuration for the websudoer app
echo "www-data ALL=(ALL) NOPASSWD: /usr/local/websudoer/websudoer.sh" >> /etc/sudoers

# Apache configuration
sed -i.bkp '/VirtualHost>/i #added lines\n\t<Directory />\n\t\tOrder deny,allow\n\t\tAllow from all\n\t</Directory>' /etc/apache2/sites-enabled/000-default.conf
sed -i 's/\/var\/www\/html/\/var\/www/g' /etc/apache2/sites-enabled/000-default.conf

# Add scripts
mkdir /usr/local/proteo
mkdir /usr/local/proteo/websudoer

# After the post off the first version of this script on github, change it to download scripts
cp websudoer.sh /usr/local/proteo/websudoer/

rm -rf /var/www/*

cp -r Web/* /var/www/
