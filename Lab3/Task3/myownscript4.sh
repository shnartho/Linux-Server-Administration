#!/bin/bash

echo "What operating system are you using bro: "
read VAR1;

if [[ "$VAR1" == "Linux" ]]; then
    echo "Great Choice!"
else
    echo "Is $VAR1 a operating system!"
fi



