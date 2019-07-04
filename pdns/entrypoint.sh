#!/usr/bin/env sh

SQL_SCHEMA=/pdns/schema.sql

# Import DB Schema Structure
if [[ -f ${SQL_SCHEMA} ]]; then
	echo "<< Creating database schema.. >>"
	sqlite3 /pdns/pdns_db.sqlite < ${SQL_SCHEMA}
	chmod 755 -R /pdns/pdns_db.sqlite
	chown -R pdns:pdns /pdns/pdns_db.sqlite
	rm ${SQL_SCHEMA}
	echo "<< Done >>"
else
	echo "<< Database Ready! >>"
fi

# RUN Service
pdns_server \
	--loglevel=${PDNS_LOG_LEVEL:-0} \
	--webserver-allow-from=${PDNS_WEBSERVER_ALLOWED_FROM:-"127.0.0.1,::1"} \
	--webserver-password=${PDNS_WEBSERVER_PASSWORD:-""} \
	--api-key=${PDNS_API_KEY}
