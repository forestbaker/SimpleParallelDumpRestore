## Usage:

./dumpDatabase.sh [-j jobs]

./restoreSchema.sh \<oldSchemaName\> \<newSchemaName\>

## Description

Dumps and restores all tables in a MySQL database parallel using GNU parallel
tool [1].

Dump command creates a schema file and one comma separated data file for all
tables with "Select ... into outFile" statement with "mysql" command. Restore
command executes this files using "Load data inFile" statement.

MySQL user with sufficient privileges should be specified in "my.cnf".

[1] http://www.gnu.org/software/parallel
