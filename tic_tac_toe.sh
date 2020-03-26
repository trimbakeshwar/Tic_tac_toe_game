#!/bin/bash -x
echo "welcome to tic_tac_toe"
declare -A bord
ROW=3
COLUMN=3
function reseting(){
for (( i=0; i<$ROW; i++ ))
do
	for (( j=0; j<$COLUMN; j++ ))
	do
		bord[$i,$j]=" "
	done
done
}
reseting
function toss(){
	toss=((RANDOM%2))
	case $toss in 
		1)
			player=X ;;
		2)
			player=O ;;
	esac
}
