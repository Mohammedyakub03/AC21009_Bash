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