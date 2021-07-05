#!/bin/bash
echo "Flip Coin Combination"

# dictionary declaration
declare -A output

#singlet combination
output[H]=0
output[T]=0

#doublet combination
output[HH]=0
output[HT]=0
output[TH]=0
output[TT]=0

#type of flip
echo "singlet:1 doublet:2"
read type

#no of flips
echo "give no of flips:"
read n

#for singlet combination
function singletFlipCoin()
{
	n=$1
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

	#output percent calculation
	percentH=`awk -v h=${output[H]} -v n=$n 'BEGIN {print (h/n))}'`
	percentT=`awk -v t=${output[T]} -v n=$n 'BEGIN {print (t/n)}'`

	#printing for singlet
	echo "No of flips:$n"
	echo "Heads: ${output[H]}, percent:$percentH"
	echo "Tails: ${output[T]}, percent:$percentT"
}

#for doublet combination
function doubletFlipCoin()
{
	n=$1
	for((count=0;count<$n;count++))
	do
		val1=$((RANDOM%2))
		val2=$((RANDOM%2))
		if [ $val1 -eq 1 -a $val2 -eq 1 ]
		then
			((output[HH]++))
		elif [ $val1 -eq 0 -a $val2 -eq 0 ]
		then
			((output[TT]++))
		elif [ $val1 -eq 1 -a $val2 -eq 0 ]
		then
			((output[HT]++))
		else
			((output[TH]++))
		fi
	done

	#output percent calculation
	percentHH=`awk -v hh=${output[HH]} -v n=$n 'BEGIN {print (hh/n)}'`
	percentTT=`awk -v tt=${output[TT]} -v n=$n 'BEGIN {print (tt/n)}'`
	percentHT=`awk -v ht=${output[HT]} -v n=$n 'BEGIN {print (ht/n)}'`
	percentTH=`awk -v th=${output[TH]} -v n=$n 'BEGIN {print (th/n)}'`

	#printing for doublet
	echo "Heads: ${output[HH]}, percent: $percentHH"
	echo "Tails: ${output[TT]}, percent: $percentTT"
	echo "Heads: ${output[HT]}, percent: $percentHT"
	echo "Tails: ${output[TH]}, percent: $percentTH"
}
if [ $type -eq 2 ]
then
	doubletFlipCoin $n
elif [ $type -eq 1 ]
then
	singletFlipCoin $n
else
	echo "wrong choice"
fi
