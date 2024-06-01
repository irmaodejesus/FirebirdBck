#!/bin/bash

sudo touch /var/log/log.firebirdbck.install 
# File log name.
log_file="/var/log/log.firebirdbck.install"

# Function to write log messages
log_message() {
    echo "$(date +"%Y-%m-%d %T") - $1" >> "$log_file"
}

#Aqui instala o FirebirdBack para poder funcionar corretamente.
#torna todos os scripts executaveis
sudo chmod -Rf +x *.sh
#criar o arquivo do log
sudo touch /var/log/log.FirebirdBck 
#estabeçecer um local padrao para o backup e adicionar no arquivo de configuracao
sudo mkdir -p /opt/firebirdbck/day{1..7} /opt/firebirdbck/mount /etc/firebirdbck /opt/firebirdbck/key
#montar a pasta remota e criar a estrutura de pastas.
#copiar o arquivo de configuracao mp /etc/firebirbck
sudo cp script/FirebirdBck.conf /etc/firebirdbck
#copiar os scripts  arquivo de scripts para o /sbin/
sudo cp script/*.sh /sbin
#checar o espaco disponivel em /opt/firebirdbck/ e informar ao usuario

#instalar o script automatico no cron
