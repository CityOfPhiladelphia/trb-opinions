for pdf in `ls $1`
do
  ./s3up.sh $pdf trb application/pdf
done
