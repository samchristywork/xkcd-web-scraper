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
  cat << EOF > index.html
<!DOCTYPE html>
<html>
<head>
  <title>XKCD</title>
  <meta http-equiv="Content-type" content="text/html; charset=utf-8">
  <meta name="viewport" content="width=device-width, initial-scale=1">
  <link rel="stylesheet" href="style.css" type="text/css">
</head>
<body>
EOF
  for i in `seq $1 $2`; do
    echo "Downloading metadata: $i"
    curl -s https://xkcd.com/$i/ | \
      awk "/ctitle/; /<div.id..comic.>/,/<.div>/" | \
      sed "s/..imgs.xkcd.com\/comics/imgs/g" >> index.html
  done
  cat << EOF >> index.html
</body>
</html>
EOF

  # Download images
  mkdir -p imgs
  grep "^<img" index.html | \
    cut -f2 -d'"' | \
    sed "s/.\+/curl -s \"https:\/\/imgs.xkcd.com\/comics\/&\" --output \"&\"; echo Downloading image: \"&\"/g" | \
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
