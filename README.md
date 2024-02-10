# Open-DMARC-Analyzer-dockerbuilder
A docker builder for Open-DMARC-Analyzer

## Getting Started

These instructions will get you a copy of the project up and running on your local machine for development and testing purposes. See deployment for notes on how to deploy the project on a live system.

### Prerequisites

Please you must have docker or docker desktop installed to build the image.
By default, we use traefik to deploy directly website to an local website. You can change traefik label to directly map to localport.

### Installing

To prepare, the docker image first download need repository with

```
make install
```

Before build please edit the both config file 

for Open-DMARC-Analyzer
copy the example to code/config.php.pub and edit the following part

```php
// Database Settings

define('DB_HOST', 'mysql');
define('DB_USER', 'root');
define('DB_PASS', 'root');
define('DB_NAME', 'dmarc');
define('DB_PORT', '3306'); // default port 3306, 5432 for pgsql
define('DB_TYPE', 'mysql'); // supported mysql and pgsql

```

and for dmarcts-report, edit the following file parser/dmarcts-report-parser.conf 

```perl

# Supported types: mysql, Pg. If unset, defaults to mysql
$dbtype = 'mysql';
$dbname = 'dmarc';
$dbuser = 'root';
$dbpass = 'root';
$dbhost = 'mysql'; # Set the hostname if we can't connect to the local socket.
$dbport = '3306';

$imapserver       = 'IMAP SERVER';
$imapuser         = 'IMAP Account email';
$imappass         = 'IMAP Account PASS';
$imapport         = '143';
$imapssl          = '0';        # If set to 1, remember to change server port to 993 and disable imaptls.
$imaptls          = '1';        # Enabled as the default and best-practice.
$tlsverify        = '0';        # Enable verify server cert as the default and best-practice.
$imapignoreerror  = '0';          # set it to 1 if you see an "ERROR: message_string() 
                                # expected 119613 bytes but received 81873 you may 
  
```

after that to build image, type

```
make build
```

Edit WEB variable in Makefile to match your traefik url 
```makefile
VERSION=0.7
WEB=dmark.local.meyn.fr # <- match to your url
.PHONY: serve

```

And launch the image

```
make serve
```

## Authors

* **Samuel  M - Olopost** - *Initial work* - [Site](https://www.meyn.fr)

## License

This project is licensed under the MIT License - see the [LICENSE.md](LICENSE.md) file for details

