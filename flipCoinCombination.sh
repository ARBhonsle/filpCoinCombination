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

#triplet combination
output[HHH]=0
output[HHT]=0
output[HTH]=0
output[HTT]=0
output[THH]=0
output[THT]=0
output[TTH]=0
output[TTT]=0

#type of flip
echo "singlet:1 doublet:2 triplet:3 all:4"
read type

#no of flips
echo "give no of coin flips:(for type:$type)"
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
	percentH=`awk -v h=${output[H]} -v n=$n 'BEGIN {print (h/n)}'`
	percentT=`awk -v t=${output[T]} -v n=$n 'BEGIN {print (t/n)}'`

	#printing for singlet
	echo "No of flips:$n"
	echo "H: ${output[H]}, percent:$percentH"
	echo "T: ${output[T]}, percent:$percentT"
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
	echo "HH: ${output[HH]}, percent: $percentHH"
	echo "TT: ${output[TT]}, percent: $percentTT"
	echo "HT: ${output[HT]}, percent: $percentHT"
	echo "TH: ${output[TH]}, percent: $percentTH"
}

#for triplet combination
#for doublet combination
function tripletFlipCoin()
{
	n=$1
	for((count=0;count<$n;count++))
	do
		val1=$((RANDOM%2))
		val2=$((RANDOM%2))
		val3=$((RANDOM%2))
		if [ $val1 -eq 1 -a $val2 -eq 1 ]
		then
			if [ $val3 -eq 1 ]
			then
				((output[HHH]++))
			else
				((output[HHT]++))
			fi
		elif [ $val1 -eq 0 -a $val2 -eq 0 ]
		then
			if [ $val3 -eq 1 ]
			then
				((output[TTH]++))
			else
				((output[TTT]++))
			fi
		elif [ $val1 -eq 1 -a $val2 -eq 0 ]
		then
			if [ $val3 -eq 1 ]
			then
				((output[HTH]++))
			else
				((output[HTT]++))
			fi
		else
			if [ $val3 -eq 1 ]
			then
				((output[THH]++))
			else
				((output[THT]++))
			fi
		fi
	done

	#output percent calculation
	percentHHH=`awk -v hhh=${output[HHH]} -v n=$n 'BEGIN {print (hhh/n)}'`
	percentTTH=`awk -v tth=${output[TTH]} -v n=$n 'BEGIN {print (tth/n)}'`
	percentHTH=`awk -v hth=${output[HTH]} -v n=$n 'BEGIN {print (hth/n)}'`
	percentTHH=`awk -v thh=${output[THH]} -v n=$n 'BEGIN {print (thh/n)}'`
	percentHHT=`awk -v hht=${output[HHT]} -v n=$n 'BEGIN {print (hht/n)}'`
	percentTTT=`awk -v ttt=${output[TTT]} -v n=$n 'BEGIN {print (ttt/n)}'`
	percentHTT=`awk -v htt=${output[HTT]} -v n=$n 'BEGIN {print (htt/n)}'`
	percentTHT=`awk -v tht=${output[THT]} -v n=$n 'BEGIN {print (tht/n)}'`

	#printing for doublet
	echo "HHH: ${output[HHH]}, percent: $percentHHH"
	echo "TTH: ${output[TTH]}, percent: $percentTTH"
	echo "HTH: ${output[HTH]}, percent: $percentHTH"
	echo "THH: ${output[THH]}, percent: $percentTHH"
	echo "HHT: ${output[HHT]}, percent: $percentHHT"
	echo "TTT: ${output[TTT]}, percent: $percentTTT"
	echo "HTT: ${output[HTT]}, percent: $percentHTT"
	echo "THT: ${output[THT]}, percent: $percentTHT"
}

if [ $type -eq 2 ]
then
	doubletFlipCoin $n
elif [ $type -eq 1 ]
then
	singletFlipCoin $n
elif [ $type -eq 3 ]
then
	tripletFlipCoin $n
else
	singletFlipCoin $n
	doubletFlipCoin $n
	tripletFlipCoin $n
fi

#sort to get winning combination
declare -a wins
c=0
max=H
for key in ${!output[@]}
do
	wins[((c++))]=$((output[$key]))
	if [ $((output[$max])) -lt $((output[$key])) ]
	then
		max=$key
	fi
done
echo "wins array:${wins[@]}"
for((c=0;c<${#wins[@]};c++))
do
	for((i=0;i<$((${#wins[@]}-1));i++))
	do
		if [ $((wins[$i])) -gt $((wins[$(($i+1))])) ]
		then
			temp=$((wins[$i]))
			wins[$i]=$((wins[$(($i+1))]))
			wins[$(($i+1))]=$temp
		fi
	done
done
echo "Sorted wins:${wins[*]}"
echo "Wining Combination:$max"
