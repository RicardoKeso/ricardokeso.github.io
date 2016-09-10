# cat mail 
#!/bin/bash

header=/etc/ssmtp/header.txt

makeHeader(){
	echo "From: \"`hostname`.ricardokeso.com\" <notificacao@ricardokeso.com>" > $header
	echo "To: $1" >> $header
	echo "Subject: On-line (`curl -s checkip.amazonaws.com`)" >> $header
}

if [ "$#" == "1" ]; then
	makeHeader $1
	mutt -H $header < /dev/null
elif [ "$#" == "2" ]; then
	makeHeader $1
	mutt -H $header -a $2 < /dev/null
else
	echo ""
	echo "Erro no parametros. Apenas email ou email e anexo"
	echo "ex.: [$0 \"abc@abc.com\"] ou [$0 \"abc@abc.com\" \"caminhoDoAnexo\"]"
	echo ""
fi

echo "" > $header
