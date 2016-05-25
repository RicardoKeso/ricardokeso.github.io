#!/bin/sh

clear
echo ""

echo "Title: "$1
titulo=`echo $1 | awk '{print tolower($0)}'`
#echo $titulo

tituloHtml=`echo $titulo | sed "s/ /%20/g"`
#echo "titulo HTML: "$tituloHtml

imdbID=`curl -s "http://www.omdbapi.com/?t=$tituloHtml&plot=full&r=json" | sed "s/imdbID\":\"/\|/" | cut -d '|' -f2 | cut -d '"' -f1`
echo "IMDb ID: "$imdbID

codSub=`curl -s http://www.yifysubtitles.com/movie-imdb/$imdbID | grep "brazilian-portuguese" | sed "s/brazilian-portuguese-yify-/|/" | cut -d '|' -f2 | cut -d '"' -f1`
#echo "Cod Sub: "$codSub

arquivo=`echo $titulo-brazilian-portuguese-yify-$codSub.zip | sed 's/ /_/g'`
#echo "Arquivo: "$arquivo

arquivoHtml=`echo $arquivo | sed 's/_/-/g'`
#echo $arquivoHtml

wget -q "http://www.yifysubtitles.com/subtitle/$arquivoHtml"

#unzip $arquivoHtml *.srt

#rm -f $arquivoHtml

echo ""
