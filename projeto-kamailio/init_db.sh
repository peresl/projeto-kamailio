#!/bin/bash

set -e

echo "[+] Inicializando banco SQLite com schema oficial..."

mkdir -p /etc/kamailio/db

cat <<EOF | sqlite3 /etc/kamailio/db/kamailio.db
CREATE TABLE version (table_name TEXT PRIMARY KEY, table_version INTEGER);
INSERT INTO version (table_name, table_version) VALUES ('subscriber', 7);

CREATE TABLE subscriber (
    id INTEGER PRIMARY KEY AUTOINCREMENT,
    username TEXT NOT NULL,
    domain TEXT NOT NULL,
    password TEXT NOT NULL,
    email_address TEXT,
    ha1 TEXT,
    ha1b TEXT,
    rpid TEXT
);

INSERT INTO subscriber (username, domain, password) VALUES ('ashe', 'kamailio', '1234');
INSERT INTO subscriber (username, domain, password) VALUES ('braum', 'kamailio', '1234');
EOF

