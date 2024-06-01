# Copyright (c) [2024] [EMMANUEL T. PEIXOTO]
# Licensed under the MIT License. See LICENSE file in the project root for full license information.
# page official of project https://github.com/irmaodejesus/SYSADMIN.FirebirdBck



#!/bin/bash

# File log name.
log_file="/var/log/log.FirebirdBck"

# Function to write log messages
log_message() {
    echo "$(date +"%Y-%m-%d %T") - $1" >> "$log_file"
}

log_message " ---> EXEC FirebirdBckDB.sh"

# Função para exibir mensagem de início do backup
msg_inicio() {
    log_message "=====================INÍCIO BACKUP============ DATA_HORA: $DTHR "
}

# Função para exibir mensagem de término do backup
msg_termino() {
    log_message "=============TERMINO DO BACKUP=========DATA_HORA: $DTHR "
}

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

# O arquivo de bloqueio
LOCK_FILE="/tmp/FirebirdBckDB.lock"

# Função para remover o arquivo de bloqueio ao sair
remove_lock() {
    rm -f "$LOCK_FILE"
}

# Verificar se o arquivo de bloqueio existe
if [ -e "$LOCK_FILE" ]; then
    echo "Outra instância do script já está em execução."
    exit 1
else
    # Criar o arquivo de bloqueio
    touch "$LOCK_FILE"
    # Garantir que o arquivo de bloqueio será removido ao sair
    trap remove_lock EXIT 
    trap remove_lock INT TERM
fi

#teste se o nome de serviço foi configurado
test_empty_var "DB_SVC_NAME"
#Caminho e nome do banco a ser feito o backup
DB_NAME="%1"
#outras variaveis
DTHR=$(date +%d%b%y-%Hh%M)
dia_da_semana=$(date +%u)

# Início do backup
msg_inicio
# Verificar se o serviço do Firebird foi desligado
if systemctl is-active --quiet $DB_SVC_NAME; then
    log_message "ERRO: O serviço $DB_SVC_NAME está em execução. Não foi possível realizar o backup."
    msg_termino
    exit 1
fi

# Realizar backup 
backup_db() {
    local backup_day="$FOLDER_BKP_LOCAL/day$dia_da_semana/"
    local name_=$(basename "$DB_NAME")
    log_message "Executando o script no $dia_da_semana..."

    # Deletar arquivos antigos
    log_message "Deletando arquivos da pasta..."
    rm -f "$backup_day"/*

    # Iniciar backup
    log_message "Iniciando backup do $DB_NAME ..."
    gbak -backup -v -ignore -garbage -limbo "$DB_NAME" "$backup_day/$name_.$DTHR.fbk"

    # Compactar backup
    log_message "Compactando $backup_day/$name_.$DTHR.fbk..."
    tar -czf "$backup_day/$name_.$DTHR.fbk.tar.gz" "$backup_day/$name_.$DTHR.fbk"

    # Remover arquivo de backup original
    log_message "Apagando o backup $backup_day/$name_.$DTHR.fbk, para poupar espaço..."
    rm -f "$backup_day/$name_.$DTHR.fbk"

    #encrypta db
    #sera adicionado a prx versao.
}

#realiza o backup
backup_db

# Término do backup
msg_termino