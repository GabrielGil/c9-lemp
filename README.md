# c9-lemp

This repo holds all the script, config files and commands you might want to use to set up a LEMP environment using NGINX and PHP-FPM instead the defaul Apache2 runner for PHP applications on Cloud9 workspaces and the same databse server (MySQL).

### Works great with,
* Drupal 7/8
* Wordpress 4+
* Joomla 3+

### Usage

```
curl -L https://raw.githubusercontent.com/GabrielGil/c9-lemp/master/install.sh | bash
```
OR
```
wget -O - https://raw.githubusercontent.com/GabrielGil/c9-lemp/master/install.sh | bash
```

### Considerations

This simple script might have some undesired side effects.

Can create a wildcard domain for *c9.io so we dont override the default virtual site.