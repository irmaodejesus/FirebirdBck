# Copyright (c) [2024] [EMMANUEL T. PEIXOTO]
# Licensed under the MIT License. See LICENSE file in the project root for full license information.
# page official of project https://github.com/irmaodejesus/SYSADMIN.FirebirdBck


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
sudo mkdir -p /opt/firebirdbck/day{1..7} /opt/firebirdbck/mount /etc/firebirdbck /usr/local/firebirdbck/key /usr/local/firebirdbck/script
#montar a pasta remota e criar a estrutura de pastas.
#copiar o arquivo de configuracao mp /etc/firebirbck
sudo cp script/FirebirdBck.conf /etc/firebirdbck
sudo cp -f script/*.sh /usr/local/firebirdbck/script
sudo cp -f * /usr/local/firebirdbck
#criando links dos scripts para o /sbin/
sudo ln -s /usr/local/firebirdbck/script/FirebirdBck.sh /sbin/
sudo ln -s /usr/local/firebirdbck/script/FirebirdBckCron.sh /sbin/
sudo ln -s /usr/local/firebirdbck/script/FirebirdBckCtrSVC.sh /sbin/
sudo ln -s /usr/local/firebirdbck/script/FirebirdBckDB.sh /sbin/
sudo ln -s /usr/local/firebirdbck/script/FirebirdBckDYLocRot.sh /sbin/
sudo ln -s /usr/local/firebirdbck/script/FirebirdBckDYRemRot.sh /sbin/
sudo ln -s /usr/local/firebirdbck/script/FirebirdBckDYSend.sh /sbin/
sudo ln -s /usr/local/firebirdbck/script/FirebirdBckMORemRot.sh /sbin/
sudo ln -s /usr/local/firebirdbck/script/FirebirdBckNFSMount.sh /sbin/
sudo ln -s /usr/local/firebirdbck/script/FirebirdBckWKRemRot.sh /sbin/
sudo ln -s /usr/local/firebirdbck/FirebirdBckSetting.sh /sbin/
#checar o espaco disponivel em /opt/firebirdbck/ e informar ao usuario

#instalar o script automatico no cron
