#!/bin/bash

direc=$(dirname "$0")
echo invoking pandoc...

if [[ $2 == *.html ]]
then
   echo using HTML template...
   template=""
else
   template="--template=${direc}/template.latex"   
fi

pandoc "$1" \
    --standalone \
    ${template} \
    --highlight-style ${direc}/pygments.theme \
    --pdf-engine=xelatex \
    -V linkcolor:blue \
    -V papersize=letter \
    -V geometry:margin=1in \
    -V mainfont="IBM Plex Mono" \
    -V monofont="IBM Plex Mono Light" \
    -V fontsize=12pt \
    \
    -o "$2" && (

if [[ $2 == *.pdf ]]
then
    echo making folded versions...
    echo copying temporary file...
    cp $2 $direc/fold_input.pdf
    echo changing directory...
    pushd $direc > /dev/null
    pdflatex half-fold.tex > /dev/null && pdflatex quarter-fold.tex > /dev/null
    rm fold_input.pdf
    popd > /dev/null
    echo back out...
    outprefix=$(pwd)/$(basename $2 .pdf)
    mv $direc/half-fold.pdf ${outprefix}_half-fold.pdf
    mv $direc/quarter-fold.pdf ${outprefix}_quarter-fold.pdf
    echo files copied back...
fi
)
echo done!
