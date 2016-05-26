#!/bin/sh

clear
echo ""

mkdir -p Subtitles

echo "Title: "$1 | awk '{print toupper($0)}'
titulo=`echo $1 | awk '{print tolower($0)}'`
echo $titulo > searchLog

tituloHtml=`echo $titulo | sed "s/ /%20/g"`
echo "titulo HTML: "$tituloHtml >> searchLog

#imdbID=`curl -s "http://www.omdbapi.com/?t=$tituloHtml&plot=full&r=json" | sed "s/imdbID\":\"/\|/" | cut -d '|' -f2 | cut -d '"' -f1`
imdbID_ok=`curl -s http://www.yifysubtitles.com/search?q=$tituloHtml | grep "movie-imdb/tt" | grep "movie-imdb\/" | sed "s/movie-imdb\//|/" | cut -d '|' -f2 | cut -d '"' -f1`

echo "IMDb ID: "$imdbID_ok >> searchLog
echo "IMDb ID: "$imdbID_ok

codSub=`curl -s http://www.yifysubtitles.com/movie-imdb/$imdbID_ok | grep "brazilian-portuguese" | sed "s/brazilian-portuguese-yify-/|/" | cut -d '|' -f2 | cut -d '"' -f1`
echo "Cod Sub: "$codSub >> searchLog

if [ "$codSub" != "" ]; then
	arquivo=`echo $titulo-brazilian-portuguese-yify-$codSub.zip | sed 's/ /_/g'`
	echo "Arquivo: "$arquivo >> searchLog

	arquivoHtml=`echo $arquivo | sed 's/_/-/g'`

	wget -q "http://www.yifysubtitles.com/subtitle/$arquivoHtml"

	unzip -q $arquivoHtml -d Subtitles/

	rm -f $arquivoHtml
else
	echo ""
	echo "Error: codSub empty"
fi

echo ""
