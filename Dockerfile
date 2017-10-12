FROM nginx:latest

EXPOSE 443

RUN mkdir -p /etc/ssl/private
RUN chmod 600 /etc/ssl/private

WORKDIR /etc/ssl

RUN apt-get update && \
    apt-get -y install openssl && \
    apt-get clean

RUN openssl req -x509 -nodes -sha256 -newkey rsa:4096 -keyout key.pem -out cert.pem -days 365 -subj "/C=US/ST=State/L=Locale/O=Company Name/OU=Org/CN=localhost" && \
    mv key.pem private/localkey.pem && \
    mv cert.pem private/localcert.pem

WORKDIR /

COPY ./localtls.nginx.conf .
COPY ./startup.sh .

CMD [ "/startup.sh" ]