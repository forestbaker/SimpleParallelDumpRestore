#!/bin/sh
 ##
 # Tart Database Operations
 # Simple MySQL Parallel Dump & Restore
 #
 # @author      Emre Hasegeli <hasegeli@tart.com.tr>
 # @date        2011-05-23
 ##

echo "Restore started:" > $1".restore.log"
date +%s >> $1".restore.log"
echo >> $1".restore.log"

echo "Restoring schema from \""$1".schema.sql\" to "$2" database..."
mysql $2 < $1".schema.sql" 2>> $1".restore.log"

echo "Schema restored:" :> $1".restore.log"
date +%s >> $1".restore.log"
echo >> $1".restore.log"

echo "Restoring data from \""$1".data\" to "$2" database..."
for table in $1".data"/*
	do
		if [ -s $table ]; then
			mysql --execute "Set unique_checks = 0;
					Set foreign_key_checks = 0;
					Load data infile '"$(pwd)/$table"' into table "${table#$1".data/"}";" $2 2>> $1".restore.log" &
		fi
	done

echo "Waiting..."
wait

echo "All tables restored:" >: $1".restore.log"
date +%s >> $1".restore.log"
echo >> $1".restore.log"

exit 0
