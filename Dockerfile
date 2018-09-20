FROM mcr.microsoft.com/mssql-tools
COPY extract_table.conf /tmp/extract_table.conf
COPY extract_table.sh /tmp/extract_table.sh
