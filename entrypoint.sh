#!/usr/bin/env sh

SQL_SCHEMA=/schema.sql
DB_TABLE=/pdns/pdns_db.sqlite

# Import DB Schema Structure
if [[ ! -f ${DB_TABLE} ]]; then
	echo "<< Creating database schema.. >>"
	sqlite3 /pdns/pdns_db.sqlite < ${SQL_SCHEMA}
	chmod 755 -R /pdns/pdns_db.sqlite
	chown -R pdns:pdns /pdns/pdns_db.sqlite
	#rm ${SQL_SCHEMA}
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
