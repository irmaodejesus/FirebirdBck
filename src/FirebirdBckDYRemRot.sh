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

log_message " ---> EXEC FirebirdBckDYRemRot.sh"

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

pastas=("/backup_Super/day1" "/backup_Super/day2" "/backup_Super/day3" "/backup_Super/day4" "/backup_Super/day5" "/backup_Super/day6" "/backup_Super/day7")

# Obter o dia atual e os dois dias anteriores
hoje=$(date +%u)
dia_anterior1=$(( (hoje + 6) % 7 ))  # Dia anterior
dia_anterior2=$(( (hoje + 5) % 7 ))  # Dois dias atrás

# Manter conteúdo do dia atual e dos dois dias anteriores
pastas_a_manter=("/backup_Super/day$hoje" "/backup_Super/day$dia_anterior1" "/backup_Super/day$dia_anterior2")

log_message "======INCIANDO POUPA ESPACO ======"

# Iterar sobre todas as pastas
for pasta in "${pastas[@]}"; do
    if [[ " ${pastas_a_manter[@]} " =~ " $pasta " ]]; then
        # Se a pasta estiver na lista de pastas a manter, não faz nada
        log_message "Conteúdo mantido em $pasta"
    else
        # Se a pasta não estiver na lista de pastas a manter, apaga o conteúdo
        log_message "Apagando conteúdo de $pasta"
        rm -rf "$pasta"/xml/*
        log_message "Apagado conteúdo de $pasta/xml"
        rm -rf "$pasta"/super/*
        log_message "Apagado conteúdo de $pasta/super"
        rm -rf "$pasta"/pdv/*
        log_message "Apagado conteúdo de $pasta/pdv"
    fi
done
log_message "========FINALIZANDO POUPA ESPACO======="