<h1 align="center">
  Operating Systems
  <br>
</h1>

<h4 align="center">The first 3-part assignment for Operating Systems course, Bar Ilan university.

## Part 1 - Bash: gcc-find
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
## Part 2 - Bash: Tennis game
### About
The code is a shell script that simulates a board game with two players. Each player has an initial score of 50 points. The game is played in rounds, and in each round, the players enter a number between 0 and their remaining score. The player with the higher number wins the round, and their score is deducted by the amount they chose. The player who first reaches a score of 0 loses the game. The board is displayed to the screen after each round, showing the players' scores and the position of a token that moves left or right depending on the outcome of the round.

![TennisBoard](https://user-images.githubusercontent.com/92651125/187092788-ba91ed10-3f83-4096-abcf-27a88c23179a.png) 

### Implementation
The code contains several functions, each responsible for a different task. Here's a brief explanation of each function:

 * board() - This function displays the game board to the screen. It consists of an upper and lower part, and the position of the token is displayed based on the value of the $position variable.
 * playerPick() - This function asks each player to enter their choice of a number between 0 and their remaining score. It checks the validity of the input and deducts the choice from the player's score.
 * setScore() - This function sets the position of the token based on the result of the round. If player 1 wins, the token moves to the right, and if player 2 wins, the token moves to the left.
 * presentPicks() - This function displays the choices made by each player in the current round.
 * goldenTicket() - This function checks if any player has won the game by reaching a score of 0 or moving the token to the far right or left of the board.

### Execution

To run the script, simply execute it in a Bash shell. The script requires no arguments or input from the user. The game will continue until one of the players loses, and the winner will be displayed to the screen.

```bash
$ ./tennis.sh
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
```
```bash
# Run
$ ./shell
```

## Author
* [@Tal Mizrahi](https://github.com/TalMizrahii)

