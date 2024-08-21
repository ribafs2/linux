#!/bin/bash
#
# Criado/adaptado por Ribamar FS - http://ribafs.me
# Backup de arquivos. Trazendo do servidor para o desktop, a ser executado manualmente no desktop
# Efetuar o backup dos scripts do servidor e dos bancos da dados na pasta /home/ribafs/backup
#
PORT=65522
USER='ribafs'
HOST='204.48.30.243' # IP or domain
REMOTE_DIR='/home/ribafs/backup/'
LOCAL_DIR='/home/ribafs/backup-server'
scp -P $PORT -r $USER@$HOST:$REMOTE_DIR $LOCAL_DIR

