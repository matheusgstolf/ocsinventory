#!/bin/bash
# Autor: Robson Vaamonde
# Site: www.procedimentosemti.com.br
# Facebook: facebook.com/ProcedimentosEmTI
# Facebook: facebook.com/BoraParaPratica
# YouTube: youtube.com/BoraParaPratica
# Data de criação: 07/01/2018
# Data de atualização: 09/01/2018
# Versão: 0.2
# Testado e homologado para a versão do Ubuntu Server 16.04 LTS x64
# Kernel >= 4.4.x
#
# Instalação do Fusion Inventory Server e Agent com integração com GLPI
#
# Utilizar o comando: sudo -i para executar o script
#

# Arquivo de configuração de parâmetros
source 00-parametros.sh
#

# Caminho para o Log do script
LOG=$VARLOGPATH/$LOGSCRIPT
#

if [ "$USUARIO" == "0" ]
then
	if [ "$UBUNTU" == "16.04" ]
		then
			if [ "$KERNEL" == "4.4" ]
				then
					 clear
					 
					 echo -e "Usuário é `whoami`, continuando a executar o $LOGSCRIPT"
					 #Exportando a variável do Debian Frontend Noninteractive para não solicitar interação com o usuário
					 export DEBIAN_FRONTEND=noninteractive
					 echo
					 echo  ============================================================ &>> $LOG
					 
					 echo -e "Instalação do sistema de Inventário de Rede Fusion Inventory"
					 echo -e "Pressione <Enter> para instalar"
					 read
					 sleep 2
					 echo
					 
					 echo -e "Fazendo o download do Fusion Inventory Server e Agent integrado com o GLPI"
					 
					 #Download do Fusion Inventory Server, Pluguin do GLPI Help Desk
					 wget https://github.com/fusioninventory/fusioninventory-for-glpi/releases/download/$GLPIFISVERSION &>> $LOG
					 
					 #Download do Fusion Inventory Agent, integração com GLPI ou OCS Inventory
					 wget https://github.com/fusioninventory/fusioninventory-agent/releases/download/$GLPIFIAVERSION &>> $LOG
					 
					 echo -e "Download Feito com sucesso!!!, continuando o script"
					 echo
					 
					 echo -e "Descompactando o Fusion Inventory Server e Agent"
					 
					 #Descompactando o Fusion Inventory Server
					 tar -jxvf $GLPIFISTAR &>> $LOG
					 
					 #Descompactando o Fusion Inventory Agent
					 tar -zxvf $GLPIFIATAR &>> $LOG
					 
					 echo -e "Arquivos descompactados com sucesso!!!, continuando o script"
					 echo
					 
					 echo -e "Movendo o diretório do Fusion Inventory Server para o GLPI"
					 
					 #Movendo o diretório do Fusion Inventory Server para o Diretório de Pluguin do GLPI
					 mv -v $GLPIFISINSTALL /var/www/html/glpi/plugins/ &>> $LOG
					 
					 echo -e "Diretório movido com sucesso!!!, continuando o script"
					 echo
					 
					 echo -e "Instalando o Fusion Inventory Agent, pressione <Enter> para continuar."
					 read
					 sleep 2
					 clear
					 
					 #Acessando o diretório do Fusion Invetory Agent
					 cd $GLPIFIAINSTALL
					 
					 echo -e "Configurando o Fusion Inventory Agent"
					 echo
					 
					 #Configurando as opções do Fusion Inventory Agent e checando as dependências"
					 perl -I. Makefile.PL &>> $LOG
					 echo
					 echo -e "Fusion Inventory configurado com sucesso!!!, pressione <Enter> para continuar"
					 read
					 sleep 3
					 clear
					 
					 #Compilando o Fusion Inventory Agent
					 make &>> $LOG
					 echo
					 echo -e "Fusion Inventory compilado com sucesso!!!, pressione <Enter> para continuar"
					 read
					 sleep 3
					 clear
					 
					 #Instalando o Fusion Inventory Agent
					 make install &>> $LOG
					 echo
					 echo -e "Fusion Inventory Agent instalado com sucesso!!!, pressione <Enter> para continuar."
					 read
					 sleep 2
					 clear
					 
           				 echo  ============================================================ >> $LOG
                     
					 echo -e "Fim do $LOGSCRIPT em: `date`" &>> $LOG
					 echo -e "Instalação do Fusion Inventory Server e Agent feito com Sucesso!!!!!"
					 echo
					 # Script para calcular o tempo gasto para a execução do fusioninventory.sh
						 DATAFINAL=`date +%s`
						 SOMA=`expr $DATAFINAL - $DATAINICIAL`
						 RESULTADO=`expr 10800 + $SOMA`
						 TEMPO=`date -d @$RESULTADO +%H:%M:%S`
					 echo -e "Tempo gasto para execução do netdata.sh: $TEMPO"
					 echo -e "Pressione <Enter> para reinicializar o servidor: `hostname`"
					 read
					 sleep 2
					 reboot
					 else
						 echo -e "Versão do Kernel: $KERNEL não homologada para esse script, versão: >= 4.4 "
						 echo -e "Pressione <Enter> para finalizar o script"
						 read
			fi
	 	 else
			 echo -e "Distribuição GNU/Linux: `lsb_release -is` não homologada para esse script, versão: $UBUNTU"
			 echo -e "Pressione <Enter> para finalizar o script"
			 read
	fi
else
	 echo -e "Usuário não é ROOT, execute o comando com a opção: sudo -i <Enter> depois digite a senha do usuário `whoami`"
	 echo -e "Pressione <Enter> para finalizar o script"
	read
fi
