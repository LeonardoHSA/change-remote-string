#!/bin/bash
#
# Autor: LeonardoSanfins
#

listaIP=$(cat ip.txt)

# Desativa o eco (echo) do terminal - Faz com que a senha não seja exibida enquanto digita
stty -echo

# Solicita a senha para o usuário
echo "Digite a senha"
read password

# Reativa o eco (echo) do terminal
stty echo

for ip in ${listaIP[@]}
do
  echo ""
  expect -c "
     spawn ssh root@${ip} 
     expect \"password:\"
     send \"$password\r\"  
     expect \"~]#\"
     send \"sed -i "s/automatic-update:DISABLED/automatic-update:AUTOMATIC/g" "/root/arquivo.txt"\r\"
     expect \"~]#\"
     send \"cat arquivo.txt\r\"
     expect \"~]#\"
  "
  echo ""
  echo ""
  echo "*****Interação realizada*****"
  echo ""
  
done

# O spwan é usado para iniciar a execução de um programa especificado como argumento. 
# Ele cria um processo filho no qual o programa é executado.
