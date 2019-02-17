#!/bin/bash 

ProcessTag="spice"

W=$(xdpyinfo  | grep -oP 'dimensions:\s+\K\S+' | cut -d 'x' -f1 )
H=$(xdpyinfo  | grep -oP 'dimensions:\s+\K\S+' | cut -d 'x' -f2 )


declare -i ratioW=$(( $W/8 ))
declare -i ratioH=$(( $H/2 ))

echo "Resolution : $W $H " 
echo "--------------------" 
echo "Ration W : $ratioW" 
echo "Ration H : $ratioH" 


for ((a=1; a <=1 ; a++))
do
	for ((b=1; b <= 3; b++))
	do
		currentW=$(( $b * $ratioW)) 
		currentW=$(( $currentW - $ratioW)) 
		currentH=$(( $a * $ratioH))
		currentH=$(( $currentH - $ratioH))

		castedA=$( echo -n $currentW)
		castedB=$( echo -n $currentH)

		id=$(echo -n $a) 

	 	#arguments=" --zoom 50 spice://127.0.0.1:590$(printf "%01d" $a)"
	 	arguments=$( echo -n " --zoom 50 spice://127.0.0.1:59$(printf '%02d' $b)")
		remote-viewer $arguments & 

		sleep 3 

		ProcessTag=$(wmctrl -lG | grep -i $ProcessTag  | cut -d " " -f 1) 
		echo $ProcessTag
		echo wmctrl -ia $ProcessTag -N $ProcessTag
		wmctrl -ia $ProcessTag -N $ProcessTag

		sleep 1 

		option=$(echo -n "0,$castedA,$castedB,$ratioH,$ratioW") 
		
		echo "wmctrl -ia $ProcessTag -e $option"
		wmctrl -ia $ProcessTag -e $option

	done
done





