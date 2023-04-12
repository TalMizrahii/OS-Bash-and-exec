#!/bin/bash
#Tal Mizrahi 206960890

# Check for the amount of parameters.
if [ "$#" -lt 3 ]; then
  echo "Not enough parameters"
  exit 1
fi

# If the argument is a valid directory, check if it's just a folder name or a full path.
if [[ "$1" == */* ]]; then
  pathtoDir=$1
else
  # If the argument is just a folder name, concatenate the current path to it.
  pathtoDir=$(realpath "$1")
fi

# Create variables from the program arguments.
word=$2
#Save the location of the program.
ptf=$(realpath "$0")

# delete all files with .out extension in folder
find "$pathtoDir" -type f -name "*.out" -delete

# Enter to the folder.
cd "$pathtoDir" || exit 1

# The regex to find the word.
regex="\b${word}[!. ()]"

if [ -n "$(find . -maxdepth 1 -type f -name '*.c')" ]; then
  # Going over all .c files in the current directory.
  for file in *.c; do
    # If the regex finds a match in the file, the script will compile it.
    if grep -q "$regex" "$file"; then
     # Get the file's name without the .c extension.
      filename="${file%.c}"
      # Compile the file to its original name but with .out suffix.
      gcc -w -std=c99 -o "$filename.out" "$file"
    fi
  done
fi

# Check if the recursion flag is on and if there are any more folders in the directory.
if [ "$3" == "-r" ] && [ "$(ls -d */ 2>/dev/null)" ] ; then
  for dir in * ; do
    # Go over all folders in the current directory.
    if [ -d "$dir" ] ; then
      # Get the folder's name.
      sub="${dir%/}"
      # Call to gccfind.sh with the new path to the folders.
      "$ptf" "$pathtoDir/$sub" "$word" "-r"
    fi
  done
fi
