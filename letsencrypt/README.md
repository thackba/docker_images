This is a dockerized [Let's Encrpyt](https://letsencrypt.org/) client.

*Volumes*

- /etc/letsencrypt - Folder to store the 
- /var/www - This folder can be used to map the webserver folders

*Sample*

```
docker run --rm -it -v <config-folder>:/etc/letsencrypt \
                    -v <webserver-folder>:/var/www \
                    thackba/letsencrypt:latest \
                    certonly --text --webroot --rsa-key-size 4096 \
                    --email webmaster@example-domain.test \
                    --webroot-path /www/html/example-domain \
                    --domain example-domain.test \
                    --domain www.example-domain.test
```
