#!/bin/bash    
set -x
mdb-tables -1 "$1" > tables.txt
while read t ; do echo "DROP TABLE IF EXISTS \"$t\"" >> "$1.sqldump"; done < tables.txt
mdb-schema "$1" mysql >> "$1.sqldump"
while read t ; do mdb-export -D '%Y-%m-%d %H:%M:%S' -I mysql "$1" "$t" >> "$1.sqldump"; done < tables.txt
rm -f tables.txt
