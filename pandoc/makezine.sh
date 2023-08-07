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
       echo "(this is only slightly supported)"
       ;;
    *)
       echo "usage: (a4|letter|html) input.md"
       exit 1
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
   template="--template=${direc}/template.tex"
   outputfile=$outprefix.pdf
   if [[ -f $(pwd)/template.tex ]]; then
        echo using template from current directory
        template="--template=$(pwd)/template.tex"
    fi
fi

if [[ -f $outputfile ]]; then
    echo "Overwriting file $(basename $1 .md).$([[ $pagetype = html ]] && echo "html" || echo "pdf" )"
    read -p "Continue? (Y/N): " confirm && [[ $confirm == [yY] || $confirm == [yY][eE][sS] ]] || exit 1
fi

echo invoking pandoc...

# This is generic, but I might as well credit who I copied the base skeleton from.
# https://learnbyexample.github.io/customizing-pandoc/#changing-settings-via-v-option
pandoc "$1" \
    --standalone \
    ${template} \
    --embed-resources \
    --highlight-style ${direc}/pygments.theme \
    --pdf-engine=xelatex \
    -V linkcolor:blue \
    -V papersize=$pagetype \
    -V geometry:margin=1in \
    -V mainfont="DejaVu Sans" \
    -V monofont="DejaVu Sans Mono" \
    -V fontsize=12pt \
    -f markdown-smart \
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
