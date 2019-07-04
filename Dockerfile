FROM alpine:latest

MAINTAINER Kerem APAYDIN <kerem@apaydin.me>

# Install PowerDNS & SQLite Backend
RUN apk --update --no-cache add pdns pdns-backend-sqlite3 && \
    rm -rf /var/cache/apk/*

# Create Directory
RUN mkdir /pdns && \
    chmod 755 -R /pdns && \
    chown -R pdns:pdns /pdns

# Copy Configuration
ADD ./pdns/schema.sql ./pdns/entrypoint.sh /pdns/
ADD ./pdns/pdns.conf /etc/pdns/

RUN mkdir -p /var/empty/var/run/ && \
    chmod +x /pdns/entrypoint.sh

# Ports
EXPOSE 53/udp 53/tcp

# Service Start
CMD ["/pdns/entrypoint.sh"]