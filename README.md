# extract_mssql
Use docker to copy from mssql.

## 1. Fill extract_table.conf 

## 2. Build docker and run
### $ sudo docker build -t "extract_mssql" .
### $ sudo docker run --rm -it extract_mssql /bin/bash

## 3. Run extract_table.sh inside /tmp
### $ cd tmp
### $ ./extract_table.sh [schema] [table]

## 4. Copy csv file from docker to host
### $ sudo docker [docker id]:/tmp/[file] .

