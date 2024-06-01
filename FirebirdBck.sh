#!/bin/bash

# File log name.
log_file="/var/log/log.FirebirdBck"

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
