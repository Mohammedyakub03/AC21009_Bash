#!/bin/bash

function createRepository(){

	echo ""
	if [[ -d /home/$USER/repositories ]]
	then 
		echo "Directory exists for repositories!"
	else
		echo "Directory for repositories does not exist!"
		echo "Creating directory for repositories"
		sleep 1
		mkdir /home/$USER/repositories
		echo "Directory for repositories made!"
	fi

	echo ""
	success=0
	while [ $success == 0 ]
		do
		read -p "Enter name for your new repository: " input

		if [[ -d /home/$USER/repositories/"$input" ]];
		then
			echo "Repository name already in use, please try again"
		else
			mkdir -p /home/$USER/repositories/$input	
			success=1
		fi
	done

}

function selectRepository(){

	i=0
	while read line
	do
    	array[ $i ]="$line"        
    	(( i++ ))
	done < <(ls /home/$USER/repositories)

	# function i found online to dynamically create case statements
	while true;
	do
    	echo
    	for i in "${!array[@]}";
    	do
       		echo "$(($i+1))) ${array[$i]}"
    	done
    	((i++))
    	echo
   	 	read -p "Select which repository you would like to work in: " choice
    	[ -z "$choice" ] && choice=-1
    	if (( "$choice" > 0 && "$choice" <= $i )); then
        item="${array[$(($choice-1))]}"
        echo "$item"
        if [[ "$item" =~ "uefi" ]]; then # or case ...
            echo "disk uefi"
            # loaddisk 0 "$item"
        #else ...
             # loaddisk 1 "/${item}/"
        fi
        break
    else
        echo "Wrong option"
    fi
done

}