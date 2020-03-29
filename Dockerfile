FROM alpine:latest

LABEL maintainer="Ramazan APAYDIN <apaydin541@gmail.com>"

# Install PowerDNS & SQLite Backend
RUN apk --update --no-cache add pdns pdns-backend-sqlite3 && \
    rm -rf /var/cache/apk/*

# Create Directory
RUN mkdir /pdns && \
    chmod 755 -R /pdns && \
    chown -R pdns:pdns /pdns

# Copy Configuration
ADD ./schema.sql /
ADD ./entrypoint.sh /
ADD ./pdns.conf /etc/pdns/

RUN mkdir -p /var/empty/var/run/ && \
    chmod +x /entrypoint.sh

# Ports
EXPOSE 53/udp 53/tcp

# Service Start
CMD ["/entrypoint.sh"]