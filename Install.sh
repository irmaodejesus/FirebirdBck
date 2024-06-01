#!/bin/bash

# File log name.
log_file="/var/log/log.firebirdbck.install"

#Aqui instala o FirebirdBack para poder funcionar corretamente.
#criar o arquivo do log
sudo touch /var/log/log.FirebirdBck 
#estabeçecer um local padrao para o backup e adicionar no arquivo de configuracao
sudo mkdir -p /opt/firebirdbck/day{1..7} /opt/firebirdbck/mount /etc/firebirdbck /opt/firebirdbck/key
#montar a pasta remota e criar a estrutura de pastas.
#criar o arquivo de configuracao mp /etc/
sudo cp FirebirdBck.conf /etc/firebirdbck
#checar o espaco disponivel em /opt/firebirdbck/ e informar ao usuario
#copiar os scripts para dentro do /sbin
#instalar o script automatico no cron
