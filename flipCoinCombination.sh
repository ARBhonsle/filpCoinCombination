#!/bin/bash
echo "Flip Coin Combination"
declare -A output
output[H]=0
putput[T]=0
echo "give no of flips:"
read n
for((count=0;count<$n;count++))
do
	val=$((RANDOM%2))
	if [ $val -eq 1 ]
	then
		#echo "Heads"
		((output[H]++))
	else
		#echo "Tails"
		((output[T]++))
	fi
done
percentH=`awk -v h=${output[H]} 'BEGIN {print (h/20)}'`
percentT=`awk -v t=${output[T]} 'BEGIN {print (t/20)}'`
echo "No of flips:$n"
echo "Heads: ${output[H]}, percent:$percentH"
echo "Tails: ${output[T]}, percent:$percentT"
