#!/usr/bin/dumb-init /bin/sh
if [ -n "$APACHE_UID" ]; then
  usermod --non-unique --uid $APACHE_UID www-data
fi

# add dns entries for all apache vhosts
echo "127.0.0.1 $VIRTUAL_HOST" | tr ',' ' ' >> /etc/hosts

rm -f /var/run/apache2/apache2.pid

/usr/sbin/cron &
/usr/sbin/apachectl -d /etc/apache2 -e info -D FOREGROUND
