# The first 3-part assignment for Operating Systems course, Bar Ilan university.

## Part 1 - Bash
### About
The script gccfind.sh receives a folder path and a word as arguments.  
First, the script deletes all the compiled files from the folder. Afterwards, reads and compiles all c files from the folder containing the word that passed as argument.  
Possible flag is -r. If it is added, the command should also  work recursively on all sub-folders.  

## Part 2 - Bash: Tennis

The game board (the tennis court) is divided into 4 areas, 2 out lines, a seperation middle line  and a ball marked O.  
![TennisBoard](https://user-images.githubusercontent.com/92651125/187092788-ba91ed10-3f83-4096-abcf-27a88c23179a.png)  
At the beginning of the game, the ball starts on the middle line and each player starts with 50 points.  
Now in each turn both players choose a number (between 0 and the number of the current number of points they have) and reveal it together. Now the player with the lowest number "loses" the round and the ball moves towards him. Then the number that each player chose is subtracted from his points.  
If the ball is in one of the out lines, so the player whose ball is not on his side wins. If one of the players reached 0 points and the other player still has points then the player with the points won. If both players reached 0 together then the player with the ball in his zone is lost, and if the ball is still in the middle line it is a draw.

## Part 3 - Minimal Shell

In this part we will write a C program that will implement shell. The program will display a marker  (prompt) on the screen and allow the user to type commands in Linux (for example ls, cat, sleep).  
After pressing ENTER, the typed command will be executed, **in a separate process** (in the foreground, with fork and exec).  
Also, the shell will be able to receive any number of arguments where each argument (if any) will contain a full path to a folder that will be added to the environment variables.  
We will also implement 3 built-in commands by ourselves: exit, cd, history.  
When "exit" is typed, the shell will finish and exit.
