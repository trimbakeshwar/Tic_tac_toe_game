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
function displayBord(){
	for (( i=0; i<$ROW; i++ ))
	do
			echo "---+---+---+"
		for (( j=0; j<$COLUMN; j++ ))
		do
			echo -e " ${bord[$i,$j]} |\c"
   	done
		echo
	done
	echo "---+---+---+"

}
function changePlayer(){
	if [[ $player == x ]]
	then
		player=o
	else
		player=x
	fi
}
function checkEmpty(){
	if [[ ${bord[$2,$3]} == " " ]]
	then
		bord[$2,$3]=$1
		displayBord
		countOfMoves=$((countOfMoves+1))
		changePlayer $1
	else
		echo "this position is not empty"
	fi
}
function checkWin(){

	for (( i=0; i<$ROW; i++ ))
	do
		if [[ ${bord[$i,$((i-i))]} == $1 && ${bord[$i,$((i+1-i))]} == $1 && ${bord[$i,$((i+2-i))]} == $1 ]]
		then
	 		echo "win!"
    		exit
		fi
		if [[ ${bord[$((i-i)),$i]} == $1 && ${bord[$((i+1-i)),$i]} == $1 && ${bord[$((i+2-i)),$i]} == $1 ]]
		then
	 		echo "win!"
    		exit
		fi
	done
	if [[ ${bord[0,0]} == $1 && ${bord[1,1]} == $1 && ${bord[2,2]} == $1 ]]
	then
		echo "win!"
		exit
	fi
	if [[ ${bord[0,2]} == $1 && ${bord[1,1]} == $1 && ${bord[2,0]} == $1 ]]
	then 
		echo "win!"
		exit
	fi
}

function checkICanWinThenPlay(){
for (( r=0; r<$ROW; r++ ))
do
   for (( c=0; c<$COLUMN; c++ ))
   do
      if [[ ${bord[$r,$c]} == " " ]]
		then
         bord[$r,$c]=$1
         checkWin $1
         if [[ $win -eq 0 ]]
			then 
             bord[$r,$c]=" "
			fi
		fi
   done
done
}
resetingBord
tossAndAssignSymbol
displayBord
while [ $countOfMoves -lt $totalNumberOfMoves ]
do
	if [[ $player == x ]]
	then
		read -p "enter row position" rowPosition
		read -p "enter column position" columnPosition
		checkEmpty $player $rowPosition $columnPosition
		checkWin $player
	else
		position=$((RANDOM%9))
		rowPosition=$((position/3))
		columnPosition=$((position%3))
      checkEmpty $player $rowPosition $columnPosition
	fi
done
