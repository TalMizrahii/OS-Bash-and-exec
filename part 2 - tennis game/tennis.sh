#!/bin/bash

# Declaring the initiated values of the players score.
player1=50
player2=50
# Initiating the value of the position to 0.
position=0

# This function display the board to the screen.
board() {
  # This is the upper board.
  echo " Player 1: $player1         Player 2: $player2
 ---------------------------------
 |       |       #       |       |
 |       |       #       |       |"

  # By the value of the $position variable, the switch case displays the proper line of the game's state.
  case $position in
  -3)
    echo " |       |       #       |       |O"
    ;;
  -2)
    echo " |       |       #       |   O   | "
    ;;
  -1)
    echo " |       |       #   O   |       | "
    ;;
  0)
    echo " |       |       O       |       | "
    ;;
  1)
    echo " |       |   O   #       |       | "
    ;;
  2)
    echo " |   O   |       #       |       | "
    ;;
  3)
    echo "O|       |       #       |       | "
    ;;
  *)
    echo "Invalid case."
    ;;
  esac

  # The lower part of the board.
  echo " |       |       #       |       |
 |       |       #       |       |
 ---------------------------------"
}

# This function asking for the players to enter their choices.
playerPick() {
  # A flag for the loop.
  flag1=1
  # Setting the choice to 0.
  choice1=0
  while [[ $flag1 -eq 1 ]]; do
    # Asking player 1 for his choice and setting it to $choice1.
    echo -n "PLAYER 1 PICK A NUMBER: "
    # Reading player 1's choice and setting it to $choice1.
    read -s choice1
    # New line.
    echo
    # Checking if the choice is a number.
    if [[ ! $choice1 =~ ^[0-9]+$ ]]; then
      echo "NOT A VALID MOVE !"
    # Checking if the choice is not more than the amount of points the player has.
    elif [[ $choice1 -gt $player1 ]]; then
      echo "NOT A VALID MOVE !"
    # Checking if the choice is not negative.
    elif [[ $choice1 -lt 0 ]]; then
      echo "NOT A VALID MOVE !"
    else
      # If passed all tests, subtract the choice from the player's points.
      player1=$(($player1 - $choice1))
      # Set the flag to 0 to exit the loop.
      flag1=0
    fi
  done

  # A flag for the loop.
  flag2=1
  # Setting the choice to 0.
  choice2=0
  while [[ $flag2 -eq 1 ]]; do
    # Asking player 1 for his choice and setting it to $choice1.
    echo -n "PLAYER 2 PICK A NUMBER: "
    # Reading player 1's choice and setting it to $choice1.
    read -s choice2
    # New line.
    echo
    # Checking if the choice is a number.
    if [[ ! $choice2 =~ ^[0-9]+$ ]]; then
      echo "NOT A VALID MOVE !"
    # Checking if the choice is not more than the amount of points the player has.
    elif [[ $choice2 -gt $player2 ]]; then
      echo "NOT A VALID MOVE !"
    # Checking if the choice is not negative.
    elif [[ $choice2 -lt 0 ]]; then
      echo "NOT A VALID MOVE !"
    else
      # If passed all tests, subtract the choice from the player's points.
      player2=$(($player2 - $choice2))
      # Set the flag to 0 to exit the loop.
      flag2=0
    fi
  done
}

# Setting the new position to know who won the round.
setScore() {
  # If player2 won, move the token to the left.
  if [ $choice2 -gt $choice1 ]; then
    if [ $position -le 0 ]; then
      position=1
    else
      position=$((position + 1))
    fi
  fi

  # If player1 won, move the token to the right.
  if [ $choice1 -gt $choice2 ]; then
    if [ $position -ge 0 ]; then
      position=-1
    else
      position=$((position - 1))
    fi
  fi
}

# Print the result of what the players entered.
presentPicks() {
  echo -e "       Player 1 played: ${choice1}\n       Player 2 played: ${choice2}\n\n"
}

# Check if any player won the game.
goldenTicket() {
  # If the position is in -3, player1 won.
  if [ $position -eq -3 ]; then
    echo "PLAYER 1 WINS !"
    exit
  fi
  # If the position is in 3, player2 won.
  if [ $position -eq 3 ]; then
    echo "PLAYER 2 WINS !"
    exit
  fi
  # If player1 has 0 points and player2 has more than 0, player2 won.
  if [ $player1 -eq 0 ] && [ $player2 -gt 0 ]; then
    echo "PLAYER 2 WINS !"
    exit
  fi
  # If player2 has 0 points and player1 has more than 0, player1 won.
  if [ $player2 -eq 0 ] && [ $player1 -gt 0 ]; then
    echo "PLAYER 1 WINS !"
    exit
  fi
  # If both players have 0 points.
  if [ $player1 -eq 0 ] && [ $player2 -eq 0 ]; then
    # But the token is in player2's area, player1 won.
    if [ $position -lt 0 ]; then
      echo "PLAYER 1 WINS !"
      exit
    # But the token is in player1's area, player2 won.
    elif [ $position -gt 0 ]; then
      echo "PLAYER 2 WINS !"
      exit
    fi
  fi
  # If both players have 0 points and the token is in the middle, it's a draw!
  if [ $player2 -eq 0 ] && [ $player1 -eq 0 ] && [ $position -eq 0 ]; then
    echo "IT'S A DRAW !"
    exit
  fi

}

# The control-flow function to run the game.
run() {
  # Display the initiated board.
  board
  while true; do
    # Get the players picks.
    playerPick
    # Set the score.
    setScore
    # Display the board.
    board
    # Present the players picks under the board.
    presentPicks
    #Check if any player won.
    goldenTicket
  done
}
run
