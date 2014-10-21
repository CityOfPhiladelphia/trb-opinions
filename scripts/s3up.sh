#!/bin/sh
 
file=$1
bucket=$2
contentType=$3
resource="/$bucket/$file"
dateValue=`date -R`
stringToSign="PUT\n\n$contentType\n$dateValue\n$resource"
signature=`echo -en $stringToSign | openssl sha1 -hmac $S3SECRET -binary | base64`
curl -X PUT -T "$file" \
  -H "Host: $bucket.s3.amazonaws.com" \
  -H "Date: $dateValue" \
  -H "Content-Type: $contentType" \
  -H "Authorization: AWS $S3KEY:$signature" \
  https://$bucket.s3.amazonaws.com/$file
