#!/bin/bash

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

mkdir -p build/
(
  cd build/
  for i in `seq 1 100 500`; do
    mkdir -p $i;
    (
      cd $i
      downloadRange $i $(($i+100))
    )
  done
)
