#!/bin/bash
PSQL="psql --username=freecodecamp --dbname=number_guess -t --no-align -c"

RANDOM_NUMBER=$((RANDOM % 1000 + 1))
COUNT=1
echo Enter your username:
read NAME
USERNAME=$($PSQL "SELECT username FROM games WHERE username = '$NAME'")
# if username doesn't exist, insert into record
if [[ -z $USERNAME ]]
then
  INSERT_USERNAME=$($PSQL "INSERT INTO games VALUES('$NAME')")
  USERNAME=$($PSQL "SELECT username FROM games WHERE username = '$NAME'")
  echo Welcome, $USERNAME! It looks like this is your first time here.
fi
echo Guess the secret number between 1 and 1000:
read NUMBER 


while [ $NUMBER -ne $RANDOM_NUMBER ]
do
# echo $RANDOM_NUMBER
  if [[ ! $NUMBER =~ ^[0-9]+$  ]]
  then
    echo That is not an integer, guess again:
  elif [[ $NUMBER -lt $RANDOM_NUMBER ]]
  then
    echo It\'s higher than that, guess again:
    ((COUNT++))
  else
    echo It\'s lower than that, guess again:
    ((COUNT++))
  fi
  read NUMBER
done
BEST_GAME=$($PSQL "SELECT best_game FROM games WHERE username = '$USERNAME'")
if [[ $COUNT -lt $BEST_GAME || -z $BEST_GAME ]]
then
  BEST_GAME=$COUNT
fi

UPDATE_GAME_RECORD=$($PSQL "UPDATE games SET games_played = games_played + 1 WHERE username = '$USERNAME'")
UPDATE_BEST_GUESS=$($PSQL "UPDATE games SET best_game = $BEST_GAME WHERE username = '$USERNAME'")
echo "You guessed it in $COUNT tries. The secret number was $RANDOM_NUMBER. Nice job!"






