for i in {1..20}
do
   command=$(aws s3api list-buckets | grep $S3_BUCKET)
   if ! echo "$command" | grep -q "Name"
   then
     echo "bucket not found, event bridge deleted bucket"
     break
   fi
   echo " bucket found"
   sleep 10
done || exit 1