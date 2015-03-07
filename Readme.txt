//TODO

- split globalFunction.class en petit bout
- ajout de la commande pour le sudoer
- network loader, supprimer les netArrAttr[i] pour y mettre des champs humainement compréhensible (BSSID/SSID ...)
- nmcli, sortir les champs à récupérer
- connection aux réseaux sans mot de passe
- log avec log4net
- page d'install
- login passwd pour accéder à la page wireless ?
- passage au wpapassphrase pour un peu plus de secu ?
- sortir les JS
- supprimer les .class et .vphp, et interdire la visu sur les fichiers php autre que la page d'index.
- voir du coté du cron pour le refresh du wifi
- gestion du bousin dans un sous répertoire apache



Installation instruction
Packages

            # Install apache2 and php5 lib
            apt-get install apache2 php5 libapache2-mod-php5

            # Install network-manager and avahi-daemon
            apt-get install network-manager avahi-daemon libnss-mdns
        

Sudo configuration

            # Add the following line in /etc/hosts
            www-data ALL=(ALL) NOPASSWD: /usr/local/proteo/websudoer/websudoer.sh            
        

Apache configuration

            # Modify /etc/apache2/sites-enabled/xxxxx
            # Add the following lines in your favourite VirtualHost
            <Directory />
                Order deny,allow
                Allow from all
            </Directory>
        

Copy files

            # Copy websudoer.sh to /usr/local/proteo/websudoer/ directory
            # Copy web site files /var/www/ directory
        

Ends

            # Reboot, avahi-daemon seems to need a reboot to work correctly
        

Troubleshooting

            # Ahah, linux is not for unlucky guys
        

