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

log_message " ---> EXEC FirebirdBckCron.sh"

#Aqui entra todo o procedimento de backup.
# 1 - desliga o servico do banco

# 2 - faz dayrotation local

# 3 - faz o backup de todos os bancos

# 4 - monta repositorio remoto

# 5 - envia a copia do dia para o remoto

# 6 - faz o day rotation remoto

# 7 - faz o week rotation remoto 

# 8 - faz o month rotation remoto 

# 9 - desmonta o compartilhamento remoto

# 10 - inicia os servicos do banco
