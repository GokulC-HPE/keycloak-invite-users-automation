#!/bin/bash
while IFS=, read -r username email firstName lastName password
do
  ./kcadm.sh create users -r GLP_Performance \
    -s username="$username" \
    -s email="$email" \
    -s enabled=true \
    -s emailVerified=true \
    -s firstName="$firstName" \
    -s lastName="$lastName"

   userId=$(./kcadm.sh get users -r GLP_Performance --query username="$username" --format csv | tail -n1 | cut -d',' -f1 | tr -d '"')

  ./kcadm.sh set-password -r GLP_Performance --username "$username" --new-password "$password"

  ./kcadm.sh update users/$userId -r GLP_Performance -s "credentials=[{\"type\":\"password\",\"value\":\"onpremccs@123\",\"temporary\":false}]"
done < users.csv
