#!  /bin/bash

#Site configuration options
SITE_TITLE="Dev Site"
#Space-separated list of plugin ID's to install and activate
PLUGINS="advanced-custom-fields elementor"
#Set to true to wipe out and reset your wordpress install (on next container rebuild)
WP_RESET=false
WORDPRESS_INSTALLATION="/var/www/html"
# WORKDIR="/application"

echo "Setting up WordPress"
# DEVDIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )" >/dev/null 2>&1 && pwd )"
cd $WORDPRESS_INSTALLATION
if $WP_RESET ; then
    echo "Resetting WP"
    wp plugin delete $PLUGINS
    wp db reset --yes
    rm wp-config.php;
fi

if [ ! -f wp-config.php ]; then 
    echo "Configuring";
    wp config create --dbhost="db" --dbname="wordpress-dev" --dbuser="wp_user" --dbpass="wp_pass" --skip-check;
    #sleep until db is ready
    sleep 10;
    wp core install --url="http://localhost:8000" --title="$SITE_TITLE" --admin_user="$WORDPRESS_ADMIN_USER" --admin_email="$WORDPRESS_ADMIN_EMAIL" --admin_password="$WORDPRESS_ADMIN_PASSORD" --skip-email;
    wp plugin install $PLUGINS --activate
else
    echo "Already configured"
fi