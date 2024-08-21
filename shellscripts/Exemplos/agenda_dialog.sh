#!/bin/bash
#
#   Agenda Simples em Dialog
#   Autor: Daniel Lara Souza
#   Versao 0.1
while : ; do
 reposta=$(
    dialog --stdout               \
           --title     ' AGENDA  ' \
           --menu    'Escolha um opcao: ' \
           0 0 0            \
           1 'Adicionar Contato'   \
           2 'Listar Contatos'  \
           3 'Pesquisar Contatos ' \
           4 'Deletar Contatos'       \
           0 'Sair'      \
                   )        
   [ $? -ne 0 ] && break
  
   case "$reposta" in           
           1) nome=$( dialog --stdout --inputbox 'Digite o nome:' 0 0 )          
              fone=$( dialog --stdout --inputbox 'Digite o Telefone:' 0 0 )           
              echo $nome - $fone >> agenda;
           ;;
        
           2)  sort agenda > agenda.tmp                
               dialog --textbox agenda.tmp 0 0               
               rm -rf agenda.tmp
           ;;
        
           3)  nome=$( dialog --stdout --inputbox 'Digite o nome:' 0 0 )               
               cat agenda | grep $nome > agenda.tmp               
               dialog --textbox agenda.tmp 0 0
               rm -rf agenda.tmp
           ;;
        
           4) nome=$( dialog --stdout --inputbox 'Digite o nome:' 0 0 )
              mv agenda agenda.tmp             
              grep -v $nome agenda.tmp > agenda
              rpm -rf agenda.tmp
           ;;
   
           0)  break
  
           ;;
esac
done
