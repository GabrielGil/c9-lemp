# c9-lemp

This repo holds all the script, config files and commands you might want to
use to set up a LEMP environment using NGINX and PHP-FPM instead the defaul
Apache2 runner for PHP applications on Cloud9 workspaces and the same databse
server (MySQL).


### Works great with,

* Drupal 7/8
* Wordpress 4+
* Joomla 3+


### Usage

Run any of this commands straightaway on your c9 terminal.

```
curl -L https://raw.githubusercontent.com/GabrielGil/c9-lemp/master/install.sh | bash
```
----
```
wget -O - https://raw.githubusercontent.com/GabrielGil/c9-lemp/master/install.sh | bash
```


### Update

You can re-run this script as many times as you wish, just in case I've updated
something.


### Considerations

This is a quite simple script. It is just an easy way to configure your environment
to be up and running with NGINX and PHP-FPM.

It does not overrides the default NGINX site configuration file, so dont have to
worry about overrides if you hace already modified yours.