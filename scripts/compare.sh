dir=$1

declare -A compared
find "$dir" -type f -name '*.pdf' -print0 | while IFS= read -r -d $'\0' src
do
  find "$dir" -type f -name '*.pdf' -print0 | while IFS= read -r -d $'\0' target
  do
    if [[ "$src" = "$target" || ${compared[$src$target]} ]]
    then
      continue
    fi
    if cmp -s "$src" "$target"
    then
      echo `basename "$src"`:`basename "$target"`
      if [[ ${#src} -gt ${#target} ]]
      then
        rm "$target"
      else
        rm "$src"
      fi
    fi
    compared[$target$src]=1
  done
done
