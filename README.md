# The first 3-part assignment for Operating Systems course, Bar Ilan university.

## Part 1 - Bash
### About
This script named "gccfind.sh" is used to compile all the C files in a directory (and its subdirectories if the recursion flag is on) that contain a specific word or pattern. It can be executed in a terminal by providing three parameters: the path to the directory, the word to search for, and a flag indicating whether or not to search recursively.

### Implementation

The script is written in Bash and can be run on any Unix-based operating system. It first checks if enough parameters are provided and exits if not. If the path to the directory is a full path, it will use it, otherwise, it will concatenate the current path to it. Then, it deletes all files with the ".out" extension in the directory. After that, it enters the directory and checks if there are any C files in it. If so, it goes over them and checks if the word or pattern appears in them. If there is a match, it compiles the file using gcc and saves it with the same name but with ".out" suffix. If the recursion flag is on, it will check if there are any more folders in the directory and will call itself for each one of them.

### Execution
To execute this script, open a terminal window and navigate to the directory where the script is located. Then, type in the command

```bash
./gccfind.sh [path_to_directory] [word_to_search] [-r]
```
where the path_to_directory is the directory you want to search in, the word_to_search is the word or pattern you want to find, and the "-r" flag indicates whether to search recursively or not.

I put an example command and a test folder for the script

```bash
 ./gccfind.sh testfolder word -r
```

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
