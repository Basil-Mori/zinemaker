#!/bin/bash

direc=$(dirname "$0")

pagetype=$1

case $pagetype in
    a4)
       echo making a4 page...
       ;;
    letter)
       echo making us letter page...
       ;;
    html)
       echo making html page...
       echo "(this won't work as well)"
       ;;
    *)
       echo "usage: (a4|letter|html) input.md"
       ;;
esac

shift

outprefix=$(pwd)/$(basename $1 .md)

if [[ $pagetype == html ]]
then
   #echo using HTML template...
   template=""
   outputfile=$outprefix.html
else
   template="--template=${direc}/template.latex"
   outputfile=$outprefix.pdf
fi

echo invoking pandoc...

pandoc "$1" \
    --standalone \
    ${template} \
    --highlight-style ${direc}/pygments.theme \
    --pdf-engine=xelatex \
    -V linkcolor:blue \
    -V papersize=$pagetype \
    -V geometry:margin=1in \
    -V mainfont="IBM Plex Mono" \
    -V monofont="IBM Plex Mono Light" \
    -V fontsize=12pt \
    \
    -o "$outputfile" && (

if [[ $pagetype != html ]]
then
    echo making folded versions...
    echo copying temporary file...
    cp $outputfile $direc/fold_input.pdf
    echo changing directory...
    pushd $direc > /dev/null
    pdflatex ${pagetype}_half-fold.tex > /dev/null && pdflatex ${pagetype}_quarter-fold.tex > /dev/null
    rm fold_input.pdf
    popd > /dev/null
    echo back out...
    mv $direc/${pagetype}_half-fold.pdf ${outprefix}_half-fold.pdf
    mv $direc/${pagetype}_quarter-fold.pdf ${outprefix}_quarter-fold.pdf
    echo files copied back...
fi
)
echo done!
