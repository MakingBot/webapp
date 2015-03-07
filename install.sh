
echo 'Clean and update apt-get'
sudo apt-get clean
sudo apt-get update

echo 'Install apache2 and php5 lib'
sudo apt-get install apache2 php5 libapache2-mod-php5 -y
echo 'Install network-manager and avahi-daemon'
sudo apt-get install network-manager avahi-daemon libnss-mdns -y

echo 'Clean apt-get'
apt-get autoremove -y
