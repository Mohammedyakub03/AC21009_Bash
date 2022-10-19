#!/bin/bash

# sourcing file to be able to use functions that run menu options
source other_functions.sh

# clear the console for clarity
clear

# function display initial menu and run its options
function displayRepoMenu(){

echo ""
echo "#####"
echo "START MENU"
echo "#####"
echo ""

# select command to display options and let user choose one
# by inputting corresponding number
PS3='Choose an option: '
options=("Create Repository" "Open Repository")
select opt in "${options[@]}"; do

	# case statement for user to choose option
	case $opt in 

		# if user selects this
		"Create Repository")

			# run the create repository function
			createRepository

			# re-display menu options
			displayRepoMenu
			;;

		# if user selects this	
		"Open Repository")

			# run the select repository function
			selectRepository

			# display menu options for working in repo
			displayRepoOpenMenu
			;;
	esac	
done

}

# function to display the open repository menu
function displayRepoOpenMenu(){

echo ""
echo "#####"
echo "REPOSITORY OPTIONS"
echo "#####"
echo ""

# select command to display options and let user choose one
# by inputting corresponding number
PS3='Choose an option: '
options=("Open File" "Create File" "Create Folder" "View content of file" "Add file to Repository" "Edit Files" "Navigate" "Go Back")
select opt in "${options[@]}"; do

	# case statement for user to choose option
	case $opt in 
		"Open File")

			# run function to open a file
			openFile
			displayRepoOpenMenu
			;;
		"Add File")
			;;
		"Create Folder")
			;;
		"View content of file")
			;;
		"Add file to Repository")
			;;
		"Edit Files")

			# display the file editing options menu
			displayEditFileOptions
			;;
		"Navigate")
			;;

		# if user wants to go back a menu
		"Go Back")

			# send the user back by re-displaying prior menu
			displayRepoMenu
			;;
	esac	
done

}

# function to display the options for editing a file
function displayEditFileOptions(){

echo ""
echo "#####"
echo "EDIT FILE"
echo "#####"
echo ""

# select command to display options and let user choose one
# by inputting corresponding number
PS3='Choose an option: '
options=("Edit Contents" "Rename File" "Move File" "Delete File" "Go Back")
select opt in "${options[@]}"; do

	# case statement for user to choose option
	case $opt in 
		"Edit Contents" )
			;;
		"Rename File")
			findFile
			renameFile

			;;
		"Move File")
			;;
		"Delete File")
			;;
		"Go Back")

			# send the user back by re-displaying prior menu
			displayRepoOpenMenu
			;;
	esac	
done
}