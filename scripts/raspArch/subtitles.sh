#!/bin/sh

clear

titulo=`echo $1`
tituloOrig=""
tituloPadrao=""
tituloHtml=""
poster=""
imdbID=""
codSub=""
arquivo=""
arquivoHtml=""
saidaPing=`ping 8.8.8.8 -c 1 | grep "bytes from"`

ImdbData () {

        curl -s http://www.omdbapi.com/?t=$tituloHtml | sed 's/\",\"/\"\n\"/g' |\
         sed 's/{//g' | sed 's/}/\n/g' | grep -vi "\"rated\"\|\"response\"" |\
         sed 's/\\//g' > imdbData

        tituloOrig=`cat imdbData | grep "Title" | cut -d ":" -f2 | sed 's/"//g'`
	
	tituloPadrao=`echo "$tituloOrig"`

        poster=`cat imdbData | grep "Poster" | sed 's/\":\"/|/g' | cut -d "|" -f2 |\
         sed 's/"//g'`

        mkdir -p "$tituloPadrao"

        cat imdbData | grep -v "Poster" | sed 's/"//g' | sed 's/:/: /g'\
         > "$tituloPadrao"/"$tituloPadrao.imdb"

        wget -q "$poster" -O "$tituloPadrao"/"$tituloPadrao.jpg"
}

Subtitle () {
	imdbID=`curl -s http://www.yifysubtitles.com/search?q=$tituloHtml |\
	 grep "movie-imdb/tt" | grep "movie-imdb\/" | sed "s/movie-imdb\//|/" |\
	 cut -d '|' -f2 | cut -d '"' -f1`

	codSub=`curl -s http://www.yifysubtitles.com/movie-imdb/$imdbID |\
	 grep "brazilian-portuguese" | sed "s/brazilian-portuguese-yify-/|/" |\
	 cut -d '|' -f2 | cut -d '"' -f1`

	if [ "$codSub" != "" ]; then
		arquivo=`echo $titulo-brazilian-portuguese-yify-$codSub.zip | sed 's/ /_/g'`
		arquivoHtml=`echo $arquivo | sed 's/_/-/g'`

		wget -q "http://www.yifysubtitles.com/subtitle/$arquivoHtml"

		mkdir -p "$tituloOrig"/temp
		unzip -q $arquivoHtml -d "$tituloOrig"/temp
		mv "$tituloOrig"/temp/*.srt "$tituloOrig"/
		rm -rf "$tituloOrig"/temp

		rm -f $arquivoHtml
	else
		echo ""
		echo "Error: codSub empty"
	fi

	echo ""
}

Principal () {

	tituloHtml=`echo $titulo | sed "s/ /%20/g"`
	#echo "titulo HTML: "$tituloHtml >> searchLog
	ImdbData
	Subtitle
	echo "Title: "$tituloOrig
	echo "Imdb ID: "$imdbID
	echo ""
}

TestePing (){
	if [ "$saidaPing" = "" ]; then
		echo "Off Line"
	else
		echo "On Line"
		Principal
	fi
}

if [ "$1" = "" ]; then
	echo ""
	echo "Um titulo deve ser passado entre aspas"
	echo "Ex.: ./sub.s \"constantine\""
	echo ""
else
	TestePing
fi
