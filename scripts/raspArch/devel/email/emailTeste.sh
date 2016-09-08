# cat email
#!/bin/bash

# se nao houver parametros o e-mail sera enviado
# para o endereco do Header.txt

destino=$1
cabecalho="/etc/ssmtp/header.txt"
anexo=""
assunto="$3"

if [ "$#" == "0" ]; then
        mutt -H $cabecalho < /dev/null
elif [ "$#" == "3" ]; then
        anexo="-a $3"
        assunto="-s $2"
        mutt $destino "$assunto" -H $cabecalho $anexo < /dev/null
else
        echo ""
        echo "email 123@123.com \"assunto\" \"caminhoAnexo\" "
        echo "email"
        echo ""
fi
