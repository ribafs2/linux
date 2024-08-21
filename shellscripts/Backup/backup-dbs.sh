#!/bin/bash
# Backup manual de dois bancos
# Criado/adaptado por Ribamar FS - http://ribafs.me
# Backup dos bancos ribafs e despertai a ser realizado no servidor
DB1=ribafs_db
DB2=desp_db
SQL=/home/ribafs/backup/ribafs_desp.sql
mysqldump -uroot -p -databases $DB1 $DB2 > $SQL

