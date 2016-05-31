#!/bin/sh

#Region Variaveis
tituloOrig=""
imdbID=""
ano=""
codSub=""
erro="0"
linkFilme=""
linkTorrent=""
linkTorrent="https://yifyme.com"
#EndRegion

TituloScript (){ #Region
        clear
        echo " * * * RK Subs and Datas * * * "
        echo ""
        echo "Este script tenta encontrar:"
        echo "O arquivo .torrent, a legenda em Português do Brasil, os dados e o poster do filme. "
        echo ""
        echo ""
} #EndRegion

Mensagens () { #Region
        case $1 in

        1)
        TituloScript
        echo "O título deve original (inglês) e ser passado entre aspas"
        echo "Ex.: ./subtitles.sh \"dust in high seas\""
        echo ""
        ;;

        2)
        TituloScript
        echo "Aguarde..."
        echo ""
        ;;

        3)
        TituloScript
        echo "Title: "$tituloOrig
        echo "Imdb ID: "$imdbID
        echo ""
        ;;

        4)
        TituloScript
        echo "Erro: Titulo nao encontrado - $titulo"
        echo ""
        ;;

        5)
        TituloScript
        echo "Off Line"
        echo ""
        ;;

        6)
        TituloScript
        echo "Erro: Codigo da legenda nao encontrado"
        echo ""
        ;;

        *)
        TituloScript
        echo "Erro: funcao Mensagens"
        echo ""
        ;;

        esac
} #EndRegion

ImdbData () { #Region

        linkIMDB="$1"
        tituloHtml="$2"

        curl -s "$linkIMDB/?t=$tituloHtml" | sed 's/\",\"/\"\n\"/g' |\
         sed 's/{//g' | sed 's/}/\n/g' | grep -vi "\"rated\"\|\"response\"" |\
         sed 's/\\//g' > imdbData

        tituloOrig=`cat imdbData | grep "Title" | sed 's/:/|/'  | cut -d "|" -f2 |\
         sed 's/"//g'`

        if [ "$tituloOrig" = "" ]; then
                echo "1"
                return
        fi

        ano=`cat imdbData | grep "Year" | cut -d ":" -f2 | sed 's/"//g'`

        poster=`cat imdbData | grep "Poster" | sed 's/\":\"/|/g' | cut -d "|" -f2 |\
         sed 's/"//g'`

        mkdir -p "$tituloOrig"
        cat imdbData | grep -v "Poster" | sed 's/"//g' | sed 's/:/: /g'\
         > "$tituloOrig"/"$tituloOrig.imdb"
        wget -q "$poster" -O "$tituloOrig"/"$tituloOrig.jpg"
        rm -f imdbData

        echo "0"
        return
} #EndRegion

Subtitle () { #Region

        linkSubtitles="$1"
	tituloOrig="$2"
	tituloOrigLow="`echo "$tituloOrig" | awk '{print tolower($0)}'`"
	tituloOrigHtml=`echo "$tituloOrigLow" | sed "s/ /%20/g" `
        imdbIdLocal=""
	codSub=""
        arquivoHtml=""

        imdbIdLocal=`curl -s "$linkSubtitles/search?q=$tituloOrigHtml" |\
         grep "movie-imdb/tt" | grep "movie-imdb\/" | sed "s/movie-imdb\//|/" |\
         cut -d '|' -f2 | cut -d '"' -f1`
        
	codSub=`curl -s "$linkSubtitles/movie-imdb/$imdbIdLocal" |\
         grep "brazilian-portuguese" | sed 's/brazilian-portuguese-yify-/|/' |\
         cut -d '|' -f2 | cut -d '"' -f1`
	
        if [ "$codSub" = "" ] && [ "$imdbIdLocal" != "$imdbIdData"  ]; then
		codSub=`curl -s "$linkSubtitles/movie-imdb/$imdbIdData" |\
        	 grep "brazilian-portuguese" | sed 's/brazilian-portuguese-yify-/|/' |\
        	 cut -d '|' -f2 | cut -d '"' -f1`
	elif [ "$codSub" != "" ]; then
                arquivoHtml=`echo "$tituloOrigLow-brazilian-portuguese-yify-$codSub.zip" |\
		 sed 's/ /-/g'`
                wget -q "$linkSubtitles/subtitle/$arquivoHtml"
                mkdir -p "$tituloOrig"/temp
                unzip -q $arquivoHtml -d "$tituloOrig"/temp
                mv -f "$tituloOrig"/temp/*.srt "$tituloOrig"/
                rm -rf "$tituloOrig"/temp
                rm -f $arquivoHtml
        else
                Mensagens 6
        fi
} #EndRegion

Torrent720p (){ #Region
        linkFilme=`curl -s "$linkTorrent/search?query=$titulo ($ano)" |\
         grep -m 1 "/movie/" | sed '    s/<a href="/|/' | sed 's/"></|/' |\
         cut -d '|' -f2`
        linkTorrent=`curl -s "$linkFilme" | grep -m 1 "/download/" |\
         sed 's/<a href="/|/' | sed 's/"/|/' | cut -d '|' -f2`
        wget -q "$linkTorrent" -O "$tituloOrig"/"$tituloOrig"".(""$ano"").[720p].torrent"
} #EndRegion

TesteConexao (){ #Region

        saidaPing=`ping 8.8.8.8 -c 1 | grep "bytes from"`

        if [ "$saidaPing" = "" ]; then
                echo "0"
                return
        else
                echo "1"
                return
        fi

} #EndRegion

Principal (){ #Region

        linkIMDB_="http://www.omdbapi.com"
	linkSubtitles_="http://www.yifysubtitles.com"
	tituloBusca_=`echo "$1" | awk '{print tolower($0)}'`
        tituloHtml_=`echo "$tituloBusca_" | sed "s/ /%20/g"`
        dadosImdbErro_=""
	tituloOrig_="$tituloOrig"

        #erro padrao de entrada
        #aguarde
        #ok completo
        #titulo nao encontrado
        #off line
        #codigo legenda nao encontrado

        if [ "$tituloBusca_" = "" ] || [ "$2" != "" ]; then
                Mensagens 1
        else
                Mensagens 2
                if [ "`TesteConexao`" = "1" ]; then

                        dadosImdbErro_=`ImdbData "$linkIMDB_" "$tituloHtml_"`

                        if [ "$dadosImdbErro" = "0" ]; then
                                Subtitle "$linkSubtitles_" "$titloOrig_"
                                Torrent720p
                                Mensagens 3
                        else
                                Mensagens 4
                        fi
                else
                        Mensagens 5
                fi
        fi
} #EndRegion

Principal $1 $2
