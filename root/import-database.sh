#!/bin/bash
WORKDIR="/application"
WORDPRESS_INSTALLATION="/var/www/html"

SQL_BACKUPFILE="$WORKDIR/.devcontainer/data/sql/bdd.sql";
if [ -f $SQL_BACKUPFILE ]; then
    wp db import $SQL_BACKUPFILE --path=$WORDPRESS_INSTALLATION
fi