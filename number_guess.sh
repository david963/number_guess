#!/bin/bash
PSQL="psql --username=freecodecamp --dbname=number_guess -t --no-align -c"

echo Enter your username:
read NAME
USERNAME=$($PSQL "SELECT username FROM games WHERE username = '$NAME'")
if [[ -z $USERNAME ]]
then
  echo Welcome, $NAME! It looks like this is your first time here.
fi
echo Guess the secret number between 1 and 1000:
read NUMBER
if [[ ! $NUMBER =~ ^[0-9]+$  ]]
then
  echo That is not an integer, guess again:
fi
