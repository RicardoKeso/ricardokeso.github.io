#!/bin/sh

TituloScript (){ #Region
clear
:<<'@@@'
        echo " * * * RK Subs and Datas * * * "
        echo ""
        echo "Este script tenta encontrar:"
        echo "O arquivo .torrent, a legenda em Português do Brasil, os dados e o poster do filme. "
        echo ""
        echo ""
@@@
echo "..."
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
        echo "Title: ""$2"
        echo "Imdb ID: ""$3"
        echo ""
        ;;

        4)
        TituloScript
        echo "Erro: Titulo nao encontrado - $2"
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

        0)
        clear
        echo "vazio"
        ;;

        *)
        TituloScript
        echo "Erro: Parametro invalido"
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

        tituloOrigIMDB=`cat imdbData | grep "Title" | sed 's/:/|/'  | cut -d "|" -f2 |\
         sed 's/"//g'`

        if [ "$tituloOrigIMDB" = "" ]; then
                echo "1"
                return
        fi

        poster=`cat imdbData | grep "Poster" | sed 's/\":\"/|/g' | cut -d "|" -f2 |\
         sed 's/"//g'`

        mkdir -p "$tituloOrigIMDB"
        cat imdbData | grep -v "Poster" | sed 's/"//g' | sed 's/:/: /g'\
         > "$tituloOrigIMDB"/"$tituloOrigIMDB.imdb"
        wget -q "$poster" -O "$tituloOrigIMDB"/"$tituloOrigIMDB.jpg"

        echo "0"
        return
} #EndRegion

Subtitle () { #Region

        linkSubtitles="$1"
        tituloOrig="$2"
        tituloOrigLow="`echo "$tituloOrig" | awk '{print tolower($0)}'`"
        tituloOrigHtml=`echo "$tituloOrigLow" | sed "s/ /%20/g" `
        imdbIdLocal=""
        imdbIdData="$3"
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

        linkTorrentFonte="$1"
        tituloOrig="$2"
        ano="$3"
        linkFilme=""

        linkFilme=`curl -s "$linkTorrentFonte/search?query=$tituloOrig ($ano)" |\
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
        tituloBuscaHtml_=`echo "$1"  | awk '{print tolower($0)}' | sed 's/ /%20/g'`
        dadosImdbErro_=""
        tituloOrigIMDB_=""
        ano_=""
        imdbIdData_=""
        linkTorrent_="https://yifyme.com"

:<<'@@@'
        erro padrao de entrada
        aguarde
        ok completo
        titulo nao encontrado
        off line
        codigo legenda nao encontrado
@@@
        if [ "$tituloBuscaHtml_" = "" ] || [ "$2" != "" ]; then
                Mensagens 1
        else
                Mensagens 2
                if [ "`TesteConexao`" = "1" ]; then

                        dadosImdbErro_="`ImdbData "$linkIMDB_" "$tituloBuscaHtml_"`"

                        if [ "$dadosImdbErro_" = "0" ]; then

                                tituloOrigIMDB_=`cat imdbData | grep "Title" | sed 's/:/|/'  |\
                                 cut -d "|" -f2 | sed 's/"//g'`

                                ano_=`cat imdbData | grep "Year" | cut -d ":" -f2 | sed 's/"//g'`

                                imdbIdData_=`cat imdbData | grep "imdbID" | cut -d ":" -f2 |\
                                 sed 's/"//g'`

                                rm -f imdbData

                                Subtitle "$linkSubtitles_" "$tituloOrigIMDB_"
                                Torrent720p "$linkTorrent_" "$tituloOrigIMDB_" "$ano_"
                                Mensagens 3 "$tituloOrigIMDB_" "$imdbIdData_"
                        else
                                Mensagens 4 "$tituloBuscaHtml_"
                        fi
                else
                        Mensagens 5
                fi
        fi

} #EndRegion

Principal "$1" "$2"
