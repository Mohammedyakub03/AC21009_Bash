#!/bin/bash

clear

function displayRepoMenu(){

echo ""
PS3='Choose an option: '
options=("Create Repository" "Open Repository")
select opt in "${options[@]}"; do
	case $opt in 
		"Create Repository")
			;;
		"Open Repository")
			displayRepoOpenMenu
	esac	
done

}

function displayRepoOpenMenu(){

echo ""
PS3='Choose an option: '
options=("Open File" "Create File" "Create Folder" "View content of file" "Add file to Repository" "Edit Files" "Navigate" "Go Back")
select opt in "${options[@]}"; do
	case $opt in 
		"Open File")
			;;
		"Create File")
			echo ""
			echo "1 - Open latest version"
			echo "2 - Open earlier version"
			echo ""
			read input
			;;
		"Create Folder")
			;;
		"View content of file")
			;;
		"Add file to Repository")
			;;
		"Edit Files")
			displayEditFileOptions
			;;
		"Navigate")
			;;
		"Go Back")
			displayRepoMenu
			;;
	esac	
done

}

function displayEditFileOptions(){

echo ""
PS3='Choose an option: '
options=("Edit Contents" "Rename File" "Move File" "Delete File" "Go Back")
select opt in "${options[@]}"; do
	case $opt in 
		"Edit Contents" )
			;;
		"Rename File")
			;;
		"Move File")
			;;
		"Delete File")
			;;
		"Go Back")
			displayRepoOpenMenu
			;;
	esac	
done
}