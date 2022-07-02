#!/bin/bash

# Print a usage message
usage (){
  echo "Usage: ./$(basename $0) begin step end"
  exit 1
}

# User must specify exactly three positional arguments
[ "$#" -eq "3" ] || usage

# Assign names to positional arguments
begin=$1
step=$2
end=$3

function downloadRange {

  # Build index
  rm -rf index.html
  for i in `seq $1 $2`; do
    curl https://xkcd.com/$i/ | \
      awk "/ctitle/; /<div.id..comic.>/,/<.div>/" | \
      sed "s/..imgs.xkcd.com\/comics/imgs/g" >> index.html
  done

  # Download images
  mkdir -p imgs
  grep "^<img" index.html | \
    cut -f2 -d'"' | \
    sed "s/.\+/curl \"https:\/\/imgs.xkcd.com\/comics\/&\" --output \"&\"/g" | \
    sed "s/comics.imgs/comics/g" | \
    cat > imgs/manifest

  . imgs/manifest
}

rm -rf build/
mkdir -p build/
(
  cd build/
  for i in `seq $begin $step $end`; do
    mkdir -p $i;
    (
      cd $i
      downloadRange $i $(($i+$step))
    )
  done
)
