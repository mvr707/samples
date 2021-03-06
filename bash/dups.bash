#!/usr/bin/env bash

###
### Problem: Input File has one ID stored per line. Find and report duplicates if any.
###
### Report duplicates in three cloumns in decresing order of frequency. E.g.
###
### 		Frequency	ID	Lines
################################################################
###		3		342	4,5,6
###		2		1234	2,8
###		2		asdf	1,23

verbose=${verbose:-0}

file=$1

declare -a IDs		# Array to store IDs
declare -A count	# Hash to store repetition count for IDs
declare -A lookup	# Hash to store line numbers associated with a given ID

IFS=$'\n'		# ID can have space or tab

index=0

while read line
do
        IDs[$index]=$line
        let index=index+1
        let count['"$line"']+=1
	if [[ -z ${lookup["$line"]} ]]
	then
        	lookup["$line"]="$index"
	else
        	lookup["$line"]+=",$index"
	fi
done < $file

if (( $verbose > 0 ))
then
	echo "= IDs ="
	for i in ${!IDs[@]}; do echo "$i -> ${IDs[$i]}"; done
	# printf "%s\n" ${IDs[@]}
	echo "==="
fi

if (( $verbose > 0 ))
then
	echo "= count ="
	for i in ${!count[@]}; do echo "$i -> ${count[$i]}"; done
	echo "==="
fi

if (( $verbose > 0 ))
then
	echo "= lookup ="
	for i in ${!lookup[@]}; do echo "$i -> ${lookup[$i]}"; done
	echo "==="
fi

for i in ${!count[@]}
do
        if (( ${count[$i]} > 1 ))
        then
                echo "${count[$i]}	$i		${lookup[$i]}"
        fi
done | sort -nr



# Generate test cases
# i=0; while (( $i < 1000 )); do echo $RANDOM; let i+=1; done > a.txt
# i=0; while (( $i < 10000 )); do echo $(openssl rand 4 | od -DAn); let i+=1; done > b.txt
#
# Check results with
#	sort in.txt | uniq -c | sort -n
