#!/bin/bash -x  

ProcessTag="xterm"

W=$(xdpyinfo  | grep -oP 'dimensions:\s+\K\S+' | cut -d 'x' -f1 )
H=$(xdpyinfo  | grep -oP 'dimensions:\s+\K\S+' | cut -d 'x' -f2 )


declare -i ratioW=$(( $W/8 ))
declare -i ratioH=$(( $H/2 ))

echo "Resolution : $W $H " 
echo "--------------------" 
echo "Ration W : $ratioW" 
echo "Ration H : $ratioH" 


for ((a=1; a <=2 ; a++))
do
	for ((b=1; b <= 3; b++))
	do
		currentW=$(( $b * $ratioW)) 
		currentW=$(( $currentW - $ratioW)) 
		currentWpadding=$(( $currentW  + 200)) 

		currentH=$(( $a * $ratioH))
		currentH=$(( $currentH - $ratioH))
		currentHpadding=$(( $currentH  + 10 )) 

		castedA=$( echo -n $currentW)
		castedB=$( echo -n $currentH)

		castedAA=$( echo -n $currentWpadding)
		castedBB=$( echo -n $currentHpadding)


		xterm & 
		sleep 0.25

		WinID=$(wmctrl -lG | grep -i $ProcessTag  | cut -d " " -f 1) 
		wmctrl -ia $WinID -N $WinID

		#	sleep 3 

		option=$(echo -n "0,$castedAA,$castedBB,$ratioH,$ratioW") 
		wmctrl -ia $WinID -e $option


	done
done





