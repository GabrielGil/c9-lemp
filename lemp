#!/bin/bash

if ! [ $# -eq 1 ]
then
    echo "Usage: `basename $0` [start|restart|stop|status]"
    exit 1
fi

case "$1" in
    start)
        echo "Starting Nginx..."
        sudo service nginx start
        sleep 1
        echo "Starting PHP7..."
        sudo service php7.0-fpm start
        sleep 1
    ;;
    stop)
        echo "Stoppting Nginx..."
        sudo service nginx stop
        sleep 1
        echo "Stopping PHP7..."
        sudo service php7.0-fpm stop
        sleep 1
    ;;
    restart)
        echo "Restarting Nginx..."
        sudo service nginx restart
        sleep 1
        echo "Restarting PHP7..."
        sudo service php7.0-fpm restart
        sleep 1
    ;;
    status)
        sudo service nginx status
        sudo service php7.0-fpm status
        exit 0
    ;;
    *)
        echo "Usage: `basename $0` [start|restart|stop|status|install]"
    ;;
esac
