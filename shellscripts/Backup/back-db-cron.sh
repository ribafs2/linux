# Backup diário dos bancos ribafs_db e desp_db. Adicionar as duas entradas abaixo ao crontab -e do ribafs
0 4 * * * /usr/bin/mysqldump < ribafs_db -uroot -ppassword | /bin/gzip > /home/ribafs/backup/ribafs_db-`date +\%d\%m\%y`.sql.gz
0 4 * * * /usr/bin/mysqldump < desp_db -uroot -ppassword | /bin/gzip > /home/ribafs/backup/desp_db-`date +\%d\%m\%y`.sql.gz

