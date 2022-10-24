#!/bin/bash

# function to create a new repository
function createRepository(){

	echo ""

	# if a directory for holding repositories exists
	if [[ -d /home/$USER/repositories ]]
	then 

		# no need to create one as one exists
		echo "Directory exists for repositories!"

	# else, one does not exist already
	else
		echo "Directory for repositories does not exist!"
		echo "Creating directory for repositories"
		sleep 1

		# make the directory in the home directory of the user
		mkdir /home/$USER/repositories
		echo "Directory for repositories made!"
	fi

	echo ""

	# initialise a variable 'success' to 0 to
	# use in while loop
	success=0

	# while success is 0
	while [ $success == 0 ]
		do

		# ask the user for the name of a new repository
		read -p "Enter name for your new repository: " input

		# if a folder with the name the user has chosen
		# exists in the repositories directory
		if [[ -d /home/$USER/repositories/"$input" ]];
		then

			# tell the user the name is already used
			echo "Repository name already in use, please try again"

		# else, name is not in use already
		else

			# make a directory in repositories for the repository
			mkdir -p /home/$USER/repositories/$input
			mkdir -p /home/$USER/repositories/$input/file_backups
			mkdir -p /home/$USER/repositories/$input/files

			# set success to 1 meaning the loop is no
			# longer needed	
			success=1
		fi
	done

}

# function to let the user select the repository they want
# to work in
function selectRepository(){

	# initialise variable 'i' to 0
	i=0

	# while loop that reads in folders in the 
	# repositories directory into an array
	while read line
	do

		# append the read line to the array
    	repositoriesArray[ $i ]="$line"        
    	(( i++ ))

    	# list the repositories and read them in
	done < <(ls /home/$USER/repositories)

	# process i found online to dynamically create case statements
	# so i can't make comments on it
	while true;
	do
    	echo
    	for i in "${!repositoriesArray[@]}";
    	do
       		echo "$(($i+1))) ${repositoriesArray[$i]}"
    	done
    	((i++))
    	echo
   	 	read -p "Select which repository you would like to work in: " choice
    	[ -z "$choice" ] && choice=-1
    	if (( "$choice" > 0 && "$choice" <= $i )); then
        	item="${repositoriesArray[$(($choice-1))]}"
        	chosenRepo="$item"
        if [[ "$item" =~ "uefi" ]]; then
            echo "disk uefi"
        fi
        break
    	elses
        	echo "Input invalid, please try again"
    	fi
	done

	# change the directory to the chosen repo
	cd /home/$USER/repositories/$chosenRepo

}

# function to find a file and use the file found
# in other functions
function findFile(){

	# initialise variable 'i' to 0
	i=0

	# while loop that reads in files in repositories
	# folder into array
	while read line
	do

		# append the read line to the array
    	repoContentArray[ $i ]="$line"        
    	(( i++ ))

    	# list the files and read them in
	done < <(ls /home/$USER/repositories/$chosenRepo/files)

	# process i found online to dynamically create case statements
	# so i can't make comments on it
	while true;
	do
    	echo
    	for i in "${!repoContentArray[@]}";
    	do
       		echo "$(($i+1))) ${repoContentArray[$i]}"
    	done
    	((i++))
    	echo
   	 	read -p "Select which file you would like to $action: " choice
    	[ -z "$choice" ] && choice=-1
    	if (( "$choice" > 0 && "$choice" <= $i )); then
        	item="${repoContentArray[$(($choice-1))]}"
       		chosenFile="$item"
        if [[ "$item" =~ "uefi" ]]; then
            echo "disk uefi"
        fi
        break
    	elses
        	echo "Input invalid, please try again"
    	fi
	done
}

# function to open a file using the variable assigned in 
# findFile function
function openFile(){

	echo ""

	# select command to ask if user would like to open
	# the most recent or older version of a file
	PS3='Would you like to open the most recent version, or an older version of the file: '
	options=("Current" "Older")
	select opt in "${options[@]}"; do

		# case statement for user to choose option
		case $opt in 
			"Current" )
				
				# make sure we're in the directory to save the current version
				# of the file
				cd "/home/$USER/repositories/$chosenRepo/files"

				# open the file in a text editor
				gedit $chosenFile

				# if a folder for backups of the selected file does not exist
				if [[ ! -d "$/home/$USER/repositories/$chosenRepo/file_backups/$chosenFile" ]]
				then

					# make the folder in the directory
    				mkdir -p "/home/$USER/repositories/$chosenRepo/file_backups/$chosenFile"
				fi

				# copy file into backups of chosen file
				cp $chosenFile "/home/$USER/repositories/$chosenRepo/file_backups/$chosenFile"

				# move directory to the backup folder of chosen file
				cd "/home/$USER/repositories/$chosenRepo/file_backups/$chosenFile"

				# get the date and time in a variable
				date=$( date '+%F_%H:%M:%S' )
				fileToCut=$chosenFile

				#cut ".txt" from file name
				fileToCut=(${fileToCut%????})

				# concatenate strings to make backup file name
				fileToCopy="$fileToCut"_"$date.txt"

				# rename the file that's been copied into the 
				# files backup folder
				mv $chosenFile $fileToCopy

				# assign the most recent file added to backups
				# into a variable
				mostRecentFile=$( ls -tp | grep -v /$ | head -1 )

				# assign the 
				secondMostRecentFile=$( ls -tp | grep -v /$ | head -2 | tail -1 )

				echo "$mostRecentFile"
				echo "$secondMostRecentFile"

				if cmp -s "$mostRecentFile" "$secondMostRecentFile"
				then
					rm $mostRecentFile
				fi

				# move back to the chosen repo directory
				cd /home/$USER/repositories/$chosenRepo

				displayRepoOpenMenu
				;;
			"Older")
				cd /home/$USER/repositories/$chosenRepo/file_backups/$chosenFile
				currentDirectory=$(pwd)
				i=0

				# while loop that reads in files in repositories
				# folder into array
				while read line
				do

					# append the read line to the array
			    	backupFileArray[ $i ]="$line"        
			    	(( i++ ))

			    	# list the files and read them in
				done < <(ls $currentDirectory)

				# process i found online to dynamically create case statements
				# so i can't make comments on it
				while true;
				do
			    	echo
			    	for i in "${!backupFileArray[@]}";
			    	do
			       		echo "$(($i+1))) ${backupFileArray[$i]}"
			    	done
			    	((i++))
			    	echo
			   	 	read -p "Select which file you would like to $action: " choice
			    	[ -z "$choice" ] && choice=-1
			    	if (( "$choice" > 0 && "$choice" <= $i )); then
			        	item="${backupFileArray[$(($choice-1))]}"
			       		chosenFile="$item"
			        if [[ "$item" =~ "uefi" ]]; then
			            echo "disk uefi"
			        fi
			        break
			    	elses
			        	echo "Input invalid, please try again"
			    	fi
				done
					gedit $chosenFile
					displayRepoOpenMenu
					;;
					esac	
				done
}

# function to rename a files
function renameFile(){

	echo ""

	# run the function to find the file and return it as a variable
	read -p "What would you like to rename the file to: " renamedFile

	# remame the chosen file to whatever the user input
	mv $chosenFile $renamedFile".txt"
	echo "File renamed"
	displayEditFileOptions

}


function addFile()
{
	Echo ""

	cd "/home/$USER/repositories/$chosenRepo/files"

	read -p "Please enter the name of the file to be created: " newFile

	$ touch hello.txt

	$ ls -1

	echo "File $newFile created"
	displayEditFileOptions
}

function deleteFile(){

	echo ""

	# remove the chosen file
	rm $chosenFile
	echo "File deleted"
	displayEditFileOptions

}
