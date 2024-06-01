#!/bin/bash

# File log name.
log_file="/var/log/log.FirebirdBck"

# The name of the service of the database.
log_message() {
    echo "$(date +"%Y-%m-%d %T") - $1" >> "$log_file"
}

log_message " ---> EXEC SendBck.sh"

# MSG sstart
msg_start() {  log_message "=====================START SEND DAILY BACKUP ============" }

# Função para exibir mensagem de término do backup
msg_end() {    log_message "=============DAILY BACKUP SENT========="}

# Definir o caminho para o arquivo de configuração
CONFIG_FILE="/etc/firebirdbck/FirebirdBck.conf"

# Verificar se o arquivo de configuração existe
if [ ! -f "$CONFIG_FILE" ]; then
    log_message "Arquivo de configuração $CONFIG_FILE não encontrado!"
    exit 1
fi

# Carregar o arquivo de configuração
source $CONFIG_FILE

# Função para testar se uma variável está vazia
test_empty_var() {
    local var_name="$1"
    local var_value="${!var_name}"
    if [ -z "$var_value" ]; then
        log_message "A variável '$var_name' está vazia."
        exit 1;
    fi
}

test_empty_var "FOLDER_BKP_LOCAL"
test_empty_var "MOUNT_POINT"
# Get the day of the week (1 to 7, where 1 is Monday and 7 is Sunday).
dia_da_semana=$(date +%u)
# arguments


# local  folder
localfolder="$FOLDER_BKP_LOCAL/day$dia_da_semana"
# destination folder folder
remotefolder="$MOUNT_POINT/firebirdbck/day$dia_da_semana"

#checar no compartilhamento remoto se a pasta firebidbcd e as pastas de day 1 .. a day7 existem
#caso nao exista criar

msg_start

#AQUI INCLUIR VERIFICACAO DE ESPACO DISPONIVEL

# 1st deleted content of remote folder refer this day of before backup
sudo rm -rf "$remotefolder"/*
log_message "Content of $remotefolder/* deleted"

# Copiar a pasta local para a pasta correspondente ao dia no compartilhamento NFS
sudo cp -r "$localfolder"/* "$remotefolder"/

#AQUI INCLUI VERIFICACAO DA INTEGRIDA DA COPIA
msg_end