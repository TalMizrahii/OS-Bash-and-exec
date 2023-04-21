#include <stdio.h>
#include <stdlib.h>
#include <unistd.h>
#include <string.h>
#include <sys/wait.h>
//#include <sys/types.h>

#define MAX_SIZE 101
#define TRUE 1

// A struct to store the history of the commands and which process id ran it.
typedef struct CommandHistory {
    char name[100];
    pid_t pid;
} CommandHistory;

// Declaring a command history array to save the last 100 commands.
CommandHistory commandHistory[MAX_SIZE];
// Initiating an index counter to track new open positions.
int position = 0;


/**
 * Adding the last command to the archive of commands made.
 * @param command The command the user asked to preform.
 * @param processPid The process ID who tried to run the command.
 */
void addCommand(char *command, pid_t processPid) {
    strcpy(commandHistory[position].name, command);
    commandHistory[position].pid = processPid;
    position++;
}

/**
 * Displaying all the previous commands made with the pid of the process who made them.
 */
void displayHistory() {
    // Go over all the elements in the struct.
    int i = 0;
    for (; i < position; i++) {
        // Print the values by format.
        printf("%d %s\n", commandHistory[i].pid, commandHistory[i].name);
    }
}

/**
 * Executing the command the user asked for.
 * @param args The command and arguments the user entered.
 * @param argNum The number of arguments.
 */
void shellCommand(char *args[MAX_SIZE], char *currentFullCommand) {
    // Fork to create a new process to run the command.
    pid_t pid = fork();

    // Check if the fork failed.
    if (pid < 0) {
        perror("fork failed");
    }
    // Add the command to the archive with the son's pid came back from the fork.
    addCommand(currentFullCommand, pid);
    // If it's the child process.
    if (pid == 0) {
        // Run the command and check if it worked.
        if (execvp(args[0], args) != 0) {
            // create a new array to store the error message.
            char errMsg[110];
            // copy the command to the array.
            strcpy(errMsg, args[0]);
            // Concatenate the messages.
            strcat(errMsg, " failed");
            // Print the errors.
            perror(errMsg);
        }
        exit(1);
    }
        // If it's the father.
    else if (pid > 0 && waitpid(pid, NULL, 0) == -1) {
        perror("wait failed");
    }
}

/**
 * Getting input from the user to an array of chars.
 * @param currentFullCommand The array of chars to store the result.
 */
void getUserInput(char *currentFullCommand) {
    // Printing the prompt sign.
    printf("$ ");
    fflush(stdout);
    // Getting the users command to a string.
    scanf(" %[^\n]", currentFullCommand);
}

/**
 * Splitting the full command that the user entered to an array of string for each argument.
 * @param currentFullCommand The full command as a string.
 * @param args The array of strings to store the result.
 * @param argNum The number of arguments.
 */
void splitCommandAndArgs(char *currentFullCommand, char *args[MAX_SIZE]) {
    // A counter for the arguments amount.
    int argNum = 0;
    // Getting the first token.
    char *token = strtok(currentFullCommand, " ");
    while (token != NULL) {
        // copy the current argument to the current array position.
        args[argNum] = token;
        // Add an end line char.
        args[argNum][100] = '\0';
        // increment the counter of the arguments.
        argNum++;
        // advance the pointer.
        token = strtok(NULL, " ");
    }
    // Putting in the last position the NULL terminator.
    args[argNum] = NULL;
}

/**
 * If the command entered is one of the special commands, preform the correct action.
 * @param args The array of strings.
 * @return 0 if a special command made, 1 otherwise.
 */
int specialCommands(char *args[101], char *currentFullCommand) {
    // If it's the history (special) command.
    if (strcmp(currentFullCommand, "history") == 0) {
        // Add the command to the archive.
        addCommand(currentFullCommand, getpid());
        displayHistory();
        return 0;
    }
        // If the command was "cd", execute it from the father.
    else if (strcmp(args[0], "cd") == 0) {
        // Add the command to the archive.
        addCommand(currentFullCommand, getpid());
        // If it failed, print an error.
        if (chdir(args[1]) != 0) {
            perror("cd failed");
        }
        return 0;
    }
    // It's not a special command.
    return 1;
}

/**
 * The main function of the program. running the main loop of commands.
 * @return exit value.
 */
int main(int argc, char *argv[]) {

    // Get the current value of the PATH environment variable.
    char* addPathToEnv = getenv("PATH");
    // Loop through each argument passed to the program starting from the second one.
    int i;
    for(i = 1; i < argc; i++) {
        // Concatenate a colon and the current argument to the end of the PATH variable.
        strcat(addPathToEnv, ":");
        strcat(addPathToEnv, argv[i]);
    }
    // Set the new value of the PATH environment variable.
    setenv("PATH", addPathToEnv, 1);

    // The main while loop of the program to run.
    while (TRUE) {
        // Get input from the user to the currentFullCommand array.
        char currentFullCommand[MAX_SIZE];
        getUserInput(currentFullCommand);
        // If the user entered exit, exit.
        if (!strcmp("exit", currentFullCommand)) {
            exit(0);
        }
        // An array of string for the arguments.
        char *args[MAX_SIZE] = {0};
        // Save a copy of the full command before tokenized.
        char fullCommandCpy[101];
        strcpy(fullCommandCpy, currentFullCommand);
        splitCommandAndArgs(currentFullCommand, args);
        // Check if the user entered a special command.
        if (specialCommands(args, fullCommandCpy)) {
            // execute the command.
            shellCommand(args, fullCommandCpy);
        }
    }
}
