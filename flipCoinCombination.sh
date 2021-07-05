#!/bin/bash
echo "Flip Coin Combination"
val=$((RANDOM%2))
if [ $val -eq 1 ]
then
	echo "Heads"
else
	echo "Tails"
fi
