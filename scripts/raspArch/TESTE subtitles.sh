#!/bin/sh

titulo=`echo $1`
tituloOrig=""
tituloPadrao=""
tituloHtml=""
poster=""
imdbID=""
imdbID1=""
imdbID2=""
ano=""
codSub=""
arquivo=""
arquivoHtml=""
saidaPing=`ping 8.8.8.8 -c 1 | grep "bytes from"`
erro="0"
linkFilme=""
linkTorrent=""

TituloScript (){
        clear
        echo " * * * RK Subs and Datas * * * "
        echo ""
        echo "Este script tenta encontrar:"
        echo "O arquivo .torrent, a legenda em Português do Brasil, os dados e o poster do filme. "
        echo ""
        echo ""
}

ImdbData () {

        curl -s http://www.omdbapi.com/?t=$tituloHtml | sed 's/\",\"/\"\n\"/g' |\
         sed 's/{//g' | sed 's/}/\n/g' | grep -vi "\"rated\"\|\"response\"" |\
         sed 's/\\//g' > imdbData

        tituloOrig=`cat imdbData | grep "Title" | sed 's/:/|/'  | cut -d "|" -f2 |\
         sed 's/"//g'`

        ano=`cat imdbData | grep "Year" | cut -d ":" -f2 | sed 's/"//g'`

        imdbID1=`cat imdbData | grep "imdbID" | sed 's/:/|/'  | cut -d "|" -f2 |\
         sed 's/"//g'`

        if [ "$tituloOrig" = "" ]; then
                erro="1"
                return
        fi

        tituloPadrao=`echo "$tituloOrig"`

        poster=`cat imdbData | grep "Poster" | sed 's/\":\"/|/g' | cut -d "|" -f2 |\
         sed 's/"//g'`

        mkdir -p "$tituloPadrao"

        cat imdbData | grep -v "Poster" | sed 's/"//g' | sed 's/:/: /g'\
         > "$tituloPadrao"/"$tituloPadrao.imdb"

        wget -q "$poster" -O "$tituloPadrao"/"$tituloPadrao.jpg"

        rm -f imdbData
}

Subtitle () {

        imdbID2=`curl -s http://www.yifysubtitles.com/search?q=$tituloHtml |\
         grep "movie-imdb/tt" | grep "movie-imdb\/" | sed "s/movie-imdb\//|/" |\
         cut -d '|' -f2 | cut -d '"' -f1`

        if [ "$imdbID1" = "" ] && [ "$imdbID2" = "" ]; then
                erro="2"
                return
        else
                if [ "$imdbID2" != "" ]; then
                        imdbID="$imdbID2"
                else
                        imdbID="$imdbID1"
                fi
        fi

        codSub=`curl -s http://www.yifysubtitles.com/movie-imdb/$imdbID |\
         grep "brazilian-portuguese" | sed "s/brazilian-portuguese-yify-/|/" |\
         cut -d '|' -f2 | cut -d '"' -f1`

        if [ "$codSub" != "" ]; then
                arquivo=`echo $titulo-brazilian-portuguese-yify-$codSub.zip | sed 's/ /_/g'`
                arquivoHtml=`echo $arquivo | sed 's/_/-/g'`

                wget -q "http://www.yifysubtitles.com/subtitle/$arquivoHtml"

                mkdir -p "$tituloOrig"/temp
                unzip -q $arquivoHtml -d "$tituloOrig"/temp
                mv -f "$tituloOrig"/temp/*.srt "$tituloOrig"/
                rm -rf "$tituloOrig"/temp

                rm -f $arquivoHtml
        else
                echo ""
                echo "Error: Codigo da legenda nao encontrado"
        fi
}

Torrent (){

        linkFilme=`curl -s "https://yifyme.com/search?query=$titulo ($ano)" |\
         grep -m 1 "/movie/" | sed '    s/<a href="/|/' | sed 's/"></|/' |\
         cut -d '|' -f2`

        linkTorrent=`curl -s "$linkFilme" | grep -m 1 "/download/" |\
         sed 's/<a href="/|/' | sed 's/"/|/' | cut -d '|' -f2`

        wget -q "$linkTorrent" -O "$tituloOrig"/"$tituloOrig"".(""$ano"").[720p].torrent"
}

TestePing (){
        if [ "$saidaPing" = "" ]; then
#			echo "Off Line"
#			echo ""
			return 1
        else
#           Principal
			return 0
        fi
}

Principal () {

	if [ "$titulo" = "" ] || [ "$2" != "" ]; then
        TituloScript
        echo "O título deve original (inglês) e ser passado entre aspas"
        echo "Ex.: ./subtitles.sh \"dust in high seas\""
        echo ""
	else
        TituloScript
        echo "Aguarde..."
        TestePing
	fi


	titulo=`echo $titulo | awk '{print tolower($0)}'`
	tituloHtml=`echo $titulo | sed "s/ /%20/g"`

	ImdbData

	if [ "$erro" = "0" ]; then
			Subtitle
			Torrent
			TituloScript
			echo "Title: "$tituloOrig
			echo "Imdb ID: "$imdbID
			echo "1: "$imdbID1
			echo "2: "$imdbID2
			echo ""
	else
			TituloScript
			echo "Erro: Titulo nao encontrado - $titulo"
			echo ""
	fi
}



