srcdir=$1
destdir=$2

echo "Copying files from $srcdir to $destdir"

# from http://stackoverflow.com/a/15066129/589391
find "$srcdir" -type f -name '*.pdf' -print0 | while IFS= read -r -d $'\0' src
do
  base=`basename "$path"`
  dest="$destdir/$base"
  if [ -f "$dest" ]
  then
    if cmp --silent "$src" "$dest"
    then
      echo "These files are the same:"
    else
      echo "These files are different:"
    fi
    echo "  $src"
    echo "  $dest"
  else
    rsync "$src" "$dest"
  fi
done
