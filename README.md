This is a simple docker container that is useful for generating a standalone TLS reverse proxy locally. The basic example is you have a webserver running locally on port 3000 and your dev machine has IP address 1.2.3.4 but you need it to be served over TLS.

Simply run `docker run -e DESTHOST="<host or ip>" -e DESTPORT=<port> -p "443:443" achip/localtls`

Where `<host or ip>` is the downstream, host or IP address you want to proxy requests to and `<port>` is the port that service is listening on.

In the original example, you would run `docker run -e DESTHOST="1.2.3.4" -e DESTPORT=3000 -p "443:443" achip/localtls` and then you can access your the localtls container at https://localhost