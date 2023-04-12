# The first 3-part assignment for Operating Systems course, Bar Ilan university.

## Part 1 - Bash: gccfind
### About
This script named "gccfind.sh" is used to compile all the C files in a directory (and its subdirectories if the recursion flag is on) that contain a specific word or pattern. It can be executed in a terminal by providing three parameters: the path to the directory, the word to search for, and a flag indicating whether or not to search recursively.

### Implementation

The script is written in Bash and can be run on any Unix-based operating system. It first checks if enough parameters are provided and exits if not. If the path to the directory is a full path, it will use it, otherwise, it will concatenate the current path to it. Then, it deletes all files with the ".out" extension in the directory. After that, it enters the directory and checks if there are any C files in it. If so, it goes over them and checks if the word or pattern appears in them. If there is a match, it compiles the file using gcc and saves it with the same name but with ".out" suffix. If the recursion flag is on, it will check if there are any more folders in the directory and will call itself for each one of them.

### Execution
To execute this script, open a terminal window and navigate to the directory where the script is located. Then, type in the command

```bash
$ ./gccfind.sh [path_to_directory] [word_to_search] [-r]
```
where the path_to_directory is the directory you want to search in, the word_to_search is the word or pattern you want to find, and the "-r" flag indicates whether to search recursively or not.

I put an example command and a test folder for the script

```bash
$ ./gccfind.sh testfolder word -r
```

## Part 3 - Mini Shell
### About
This code is a simple shell that allows the user to execute basic commands, including built-in commands like "cd" and "history". The program uses fork() to create a new process to run the command and waits for the process to complete using waitpid(). The history of executed commands and their process IDs are stored in an array of structs.

### Implementation
The program is implemented in C and consists of several functions:

addCommand() - Adds the last executed command to the history of commands.
 * displayHistory() - Displays the history of executed commands.
 * shellCommand() - Executes the command entered by the user.
 * getUserInput() - Gets user input from the command line.
 * splitCommandAndArgs() - Splits the command and arguments entered by the user.
 * specialCommands() - Executes the built-in commands like "cd" and "history".
 * main() - The main function of the program that runs the main loop of commands.
 
### Execution

To run the program, simply compile the code using a C compiler and execute the resulting executable. The program will run in the command line and prompt the user for input. To exit the program, enter "exit" in the command line.

Here is an example of how to compile and run the program on Linux:

```bash
# Compile
$ gcc -o shell myshell.c

# Run
$ ./shell
```
