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
		read -p "enter row position" rowPosition
		read -p "enter column position" columnPosition
		checkEmpty $player $rowPosition $columnPosition
		checkWin $player
	fi
done
