#!/bin/bash

while IFS=, read -r username email firstName lastName password
do
  # Fetch the user ID and remove quotes
  userId=$(./kcadm.sh get users -r GLP_Performance --query username="$username" --format csv | tail -n1 | cut -d',' -f1 | tr -d '"')

  # Check if user ID exists before attempting deletion
  if [[ -n "$userId" ]]; then
    echo "Deleting user: $username (ID: $userId)"
    ./kcadm.sh delete users/$userId -r GLP_Performance
  else
    echo "User $username not found, skipping..."
  fi

done < users.csv
