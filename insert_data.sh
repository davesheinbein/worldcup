#! /bin/bash

# Check if the first argument passed to the script is "test"
if [[ $1 == "test" ]]
then
  # If "test" is the argument, connect to the 'worldcuptest' database as the 'postgres' user
  PSQL="psql --username=postgres --dbname=worldcuptest -t --no-align -c"
else
  # If no "test" argument is passed, connect to the main 'worldcup' database as the 'freecodecamp' user
  PSQL="psql --username=freecodecamp --dbname=worldcup -t --no-align -c"
fi

# Clear the existing data in the 'games' and 'teams' tables to avoid inserting duplicates
# TRUNCATE TABLE will delete all the rows in these tables
echo "$($PSQL "TRUNCATE TABLE games, teams")"

# Read the 'games.csv' file line by line
# The 'cat' command outputs the file contents and the 'while' loop reads it line by line
# 'IFS=","' sets the internal field separator to a comma, meaning fields are separated by commas
cat games.csv | while IFS="," read YEAR ROUND WINNER OPPONENT WINNER_GOALS OPPONENT_GOALS
do
  # Check if the first row of the CSV (which is the header) is being read, and skip it
  if [[ $YEAR != "year" ]]
  then
    # Get the ID of the winner team from the 'teams' table
    WINNER_ID=$($PSQL "SELECT team_id FROM teams WHERE name='$WINNER'")
    
    # If the winner team doesn't exist in the 'teams' table (empty result), insert it
    if [[ -z $WINNER_ID ]]
    then
      # Insert the winner team into the 'teams' table
      INSERT_WINNER_RESULT=$($PSQL "INSERT INTO teams(name) VALUES('$WINNER')")
      # Retrieve the newly inserted winner team's ID
      WINNER_ID=$($PSQL "SELECT team_id FROM teams WHERE name='$WINNER'")
    fi

    # Get the ID of the opponent team from the 'teams' table
    OPPONENT_ID=$($PSQL "SELECT team_id FROM teams WHERE name='$OPPONENT'")
    
    # If the opponent team doesn't exist in the 'teams' table (empty result), insert it
    if [[ -z $OPPONENT_ID ]]
    then
      # Insert the opponent team into the 'teams' table
      INSERT_OPPONENT_RESULT=$($PSQL "INSERT INTO teams(name) VALUES('$OPPONENT')")
      # Retrieve the newly inserted opponent team's ID
      OPPONENT_ID=$($PSQL "SELECT team_id FROM teams WHERE name='$OPPONENT'")
    fi

    # Insert the game data into the 'games' table, including year, round, winner, opponent, and their respective goals
    INSERT_GAME_RESULT=$($PSQL "INSERT INTO games(year, round, winner_id, opponent_id, winner_goals, opponent_goals) VALUES($YEAR, '$ROUND', $WINNER_ID, $OPPONENT_ID, $WINNER_GOALS, $OPPONENT_GOALS)")
  fi
done
 