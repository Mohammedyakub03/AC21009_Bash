#!/bin/bash

echo ""
echo "1 - Create Repository"
echo "2 - Open Repository"
echo "9 - Start Menu"
echo ""

read input 

case $input in

1)

;;

2)

echo ""
echo "1 - Open File"
echo "2 - Create File"
echo "3 - Create Folder"
echo "4 - View content of file "
echo "5 - Add file to repo (mv location to current directory)"
echo "6 - Edit Files"
echo "7 - Navigate "
echo "8 - Back"
echo "9 - Start Menu"
echo ""

read input

	case $input in 

	2)

	echo ""
	echo "1 - Open latest version"
	echo "2 - Open earlier version"
	echo ""

	read input

	;;

	6)

	echo ""
	echo "1 - Edit Contents"
	echo "2 - Rename"
	echo "3 - Move"
	echo "4 - Delete Files"
	echo ""


	read input

	;;

	esac	

esac