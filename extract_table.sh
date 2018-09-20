#!/bin/bash
export PATH=$PATH:/tmp
source extract_table.conf
export BCP_EXPORT_SCHEMA=$1
export BCP_EXPORT_TABLE=$2

echo $BCP_EXPORT_SERVER
echo $BCP_EXPORT_DB
echo $BCP_EXPORT_SCHEMA
echo $BCP_EXPORT_TABLE

sqlcmd -Q "DECLARE @colnames VARCHAR(max);set nocount on SELECT @colnames = COALESCE(@colnames + ';', '') + c.[name] from sys.schemas as s inner join sys.sysobjects as t on t.[uid] = s.[schema_id] inner join sys.syscolumns as c on c.id=t.id where t.[name]='$BCP_EXPORT_TABLE';set nocount on select @colnames;" -S $BCP_EXPORT_SERVER  -d $BCP_EXPORT_DB -U $BCP_EXPORT_USER -P $BCP_EXPORT_PWD -h-1 -o _HeadersOnly.csv

sed -r "s/\s+//g" _HeadersOnly.csv > HeadersOnly.csv 

bcp  $BCP_EXPORT_DB.$BCP_EXPORT_SCHEMA.$BCP_EXPORT_TABLE out TableDataWithoutHeaders.csv -c -U $BCP_EXPORT_USER -S $BCP_EXPORT_SERVER -P $BCP_EXPORT_PWD -t";"

cat  HeadersOnly.csv TableDataWithoutHeaders.csv > $BCP_EXPORT_SCHEMA-$BCP_EXPORT_TABLE.csv

BCP_EXPORT_SERVER=
BCP_EXPORT_DB=
BCP_EXPORT_SCHEMA=
BCP_EXPORT_TABLE=
BCP_EXPORT_USER=
BCP_EPORT_PWD=

rm _HeadersOnly.csv
rm HeadersOnly.csv
rm TableDataWithoutHeaders.csv

