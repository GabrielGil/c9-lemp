#!/bin/bash

# Redirect stdout ( > ) into a named pipe ( >() ) running "tee"
exec > >(tee /tmp/installlog.txt)
# Without this, only stdout would be captured
exec 2>&1

heroku config:get AUTH_KEY -s  >> .env
heroku config:get AUTH_SALT -s  >> .env
heroku config:get LOGGED_IN_KEY -s  >> .env
heroku config:get LOGGED_IN_SALT -s  >> .env
heroku config:get NONCE_KEY -s  >> .env
heroku config:get NONCE_SALT -s  >> .env
heroku config:get SECURE_AUTH_KEY -s  >> .env
heroku config:get SECURE_AUTH_SALT -s  >> .env
heroku config:get TABLE_PREFIX -s  >> .env
heroku config:get CLEARDB_DATABASE_URL -s  >> .env
heroku config:get SENDGRID_PASSWORD -s  >> .env
heroku config:get SENDGRID_USERNAME -s  >> .env
