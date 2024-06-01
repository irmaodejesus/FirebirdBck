#!/bin/bash

# File log name.
log_file="/var/log/log.FirebirdBck"

# Function to write log messages
log_message() {
    echo "$(date +"%Y-%m-%d %T") - $1" >> "$log_file"
}

log_message " ---> EXEC DayRotation.sh"

# Diretórios das pastas                                                                                                 pastas=("/backup_Super/day1" "/backup_Super/day2" "/backup_Super/day3" "/backup_Super/day4" "/backup_Super/day5" "/backup_Super/day6" "/backup_Super/day7")

# Obter o dia atual e os dois dias anteriores
hoje=$(date +%u)
dia_anterior1=$(( (hoje + 6) % 7 ))  # Dia anterior
dia_anterior2=$(( (hoje + 5) % 7 ))  # Dois dias atrás

# Manter conteúdo do dia atual e dos dois dias anteriores
pastas_a_manter=("/backup_Super/day$hoje" "/backup_Super/day$dia_anterior1" "/backup_Super/day$dia_anterior2")

log_file="/var/log/log.poupa_espaco"

# Função para escrever mensagens de log
log_message() {
    echo "$(date +"%Y-%m-%d %T") - $1" >> "$log_file"
}

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