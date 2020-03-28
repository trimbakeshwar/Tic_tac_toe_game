#!/bin/bash -x 
echo "welcome to tic_tac_toe"
declare -A bord
ROW=3
COLUMN=3
COUNTOFMOVES=0
COMPUTERPLAYER="o"
TOTALNUMBEROFMOVES=$((ROW*COLUMN))
#reset the bord
function resetingBord(){
	for (( i=0; i<$ROW; i++ ))
	do
		for (( j=0; j<$COLUMN; j++ ))
		do
			bord[$i,$j]=" "
		done
	done
}
#toss for who play first
function tossAndAssignSymbol(){
	toss=$((RANDOM%2))
	case $toss in
		1)
			player=x ;;
		0)
			player=$COMPUTERPLAYER ;;
	esac
	echo $player
}

#display the bord 
function displayBord(){
	for (( i=0; i<$ROW; i++ ))
	do
			echo "---+---+---+"
		for (( j=0; j<$COLUMN; j++ ))
		do
			printf " ${bord[$i,$j]} |"
		done
		echo
	done
	echo "---+---+---+"
}
# winning conditions
function checkWin(){
   win=0
   for (( i=0; i<$ROW; i++ ))
   do
      if [[ ${bord[$i,$((i-i))]} == $1 && ${bord[$i,$((i+1-i))]} == $1 && ${bord[$i,$((i+2-i))]} == $1 ]]
      then
         win=1
      elif [[ ${bord[$((i-i)),$i]} == $1 && ${bord[$((i+1-i)),$i]} == $1 &&  ${bord[$((i+2-i)),$i]} == $1 ]]
      then
         win=1
      elif [[ $i -eq 0 && ${bord[$i,$i]} == $1 && ${bord[$((i+1)),$((i+1))]} == $1 && ${bord[$((i+2)),$((i+2))]} == $1 ]]
      then
         win=1
      elif [[ ${bord[0,2]} == $1 && ${bord[1,1]} == $1 && ${bord[2,0]} == $1 ]]
      then
         win=1
	   fi
	done
}

#after evry moves change the player
function changePlayer(){
	if [[ $player == x ]]
	then
		player=o
	else
		player=x
	fi
}
#check the any place empty
function checkEmpty(){
	if [[ ${bord[$2,$3]} == " " ]]
	then
		bord[$2,$3]=$1
		displayBord
		countOfMoves=$((countOfMoves+1))
		changePlayer $1
		checkWin $1
	else
		echo "invalid place"
	fi
}
#check available corner center and sides are available and place the position
function availableCornerCenterAndSide(){
#check for available corner and place position when corner available
	if [ $flag -eq 1 ]
	then
		for (( row=0; row<$ROW; row=$(( row+2 )) ))
		do
			for (( column=0; column<$COLUMN; column=$(( column+2 )) ))
			do
				if [[ ${bord[$row,$column]} == " " ]]
				then
					bord[$row,$column]=$player
					displayBord
					flag=0
					break
				fi
			done
			if [ $flag -eq 0 ]
			then
				break
			fi
		done
	fi
#if corner not available then go for center
	if [ $flag -eq 1 ]
	then
		bord[1,1]=$player
		displayBord
		flag=0
	fi
#if center or corner not available then take any available position
	if [ $flag -eq 1 ]
	then
	for (( row=0;row<$ROW;row++ ))
	do
		for (( column=0;column<$COLUMN;column++ ))
		do
			if [[ ${bord[$row,$column]} == " " ]]
			then
				bord[$row,$column]=$player
				displayBord
				flag=0
				break
			fi
		done
	if [ $flag -eq 0 ]
	then
		break
	fi
	done
	fi
}
#check i can win if no then block other user for win
function checkICanWinThenPlayAndBlock(){
	flag=1
   for (( r=0; r<$ROW; r++ ))
   do
      for (( c=0; c<$COLUMN; c++ ))
      do
         if [[ ${bord[$r,$c]} == " " ]]
         then
            bord[$r,$c]=$1
            checkWin $1
            if [ $win -eq 0 ]
            then
                bord[$r,$c]=" "
            elif [[ $win -eq 1 && ${bord[$r,$c]} == $player ]]
            then
               displayBord
               echo "$player win !"
            exit
            elif [ $win -eq 1 ]
            then
               bord[$r,$c]=$player
               displayBord
               win=0
               flag=0
               ((COUNTOFMOVES++))
               break
            fi
         fi
      done 
   done
}


resetingBord
tossAndAssignSymbol
displayBord
while [ $COUNTOFMOVES -lt $TOTALNUMBEROFMOVES ]
do
	if [[ $player == x ]]
	then
		read -p "enter row position" rowPosition
		read -p "enter column position" columnPosition
		checkEmpty $player $rowPosition $columnPosition
	 else
		OTHERPLAYER="x"
		checkICanWinThenPlayAndBlock $player
		checkICanWinThenPlayAndBlock $OTHERPLAYER
		availableCornerCenterAndSide $player
		if [ $flag -eq 1 ]
		then
			position=$((RANDOM%9))
			rowPosition=$((position/3))
			columnPosition=$((position%3))
			checkEmpty $player $rowPosition $columnPosition
		else
			changePlayer $OTHERPLAYER
		fi
	 fi
if [[ $win == 1 ]]
then
	break
fi
done
if [[ $win == 0 ]]
then
	echo "match tie"
fi
