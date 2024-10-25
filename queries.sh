#! /bin/bash

# Set up the PostgreSQL command with the FreeCodeCamp user and the 'worldcup' database
# '--no-align' removes column alignment (useful for piping output), and '--tuples-only' returns results without extra formatting like headers
PSQL="psql --username=freecodecamp --dbname=worldcup --no-align --tuples-only -c"

# Do not change code above this line. Use the PSQL variable above to query your database.

# Query to get the total number of goals scored by the winning teams in all games
echo -e "\nTotal number of goals in all games from winning teams:"
echo "$($PSQL "SELECT SUM(winner_goals) FROM games")"

# Query to get the total number of goals scored by both teams (winners and opponents combined) in all games
echo -e "\nTotal number of goals in all games from both teams combined:"
echo "$($PSQL "SELECT SUM(winner_goals + opponent_goals) FROM games")"

# Query to get the average number of goals scored by winning teams in all games
echo -e "\nAverage number of goals in all games from the winning teams:"
echo "$($PSQL "SELECT AVG(winner_goals) FROM games")"

# Query to get the average number of goals scored by winning teams in all games, rounded to two decimal places
echo -e "\nAverage number of goals in all games from the winning teams rounded to two decimal places:"
echo "$($PSQL "SELECT TO_CHAR(ROUND(AVG(winner_goals), 2), 'FM999999999.00') FROM games")"

# Query to get the average number of goals scored by both teams combined in all games
echo -e "\nAverage number of goals in all games from both teams:"
echo "$($PSQL "SELECT AVG(winner_goals + opponent_goals) FROM games")"

# Query to get the most goals scored by a single team in a game (either winner or opponent)
echo -e "\nMost goals scored in a single game by one team:"
echo "$($PSQL "SELECT GREATEST(MAX(winner_goals), MAX(opponent_goals)) FROM games")"

# Query to count the number of games where the winning team scored more than two goals
echo -e "\nNumber of games where the winning team scored more than two goals:"
echo "$($PSQL "SELECT COUNT(*) FROM games WHERE winner_goals > 2")"

# Query to get the name of the team that won the 2018 World Cup (Final round, year 2018)
echo -e "\nWinner of the 2018 tournament team name:"
echo "$($PSQL "SELECT name FROM teams INNER JOIN games ON teams.team_id = games.winner_id WHERE round = 'Final' AND year = 2018")"

# Query to list all teams that played in the 2014 'Eighth-Final' round (both winners and opponents)
echo -e "\nList of teams who played in the 2014 'Eighth-Final' round:"
echo "$($PSQL "SELECT DISTINCT name FROM teams INNER JOIN games ON teams.team_id = games.winner_id OR teams.team_id = games.opponent_id WHERE round = 'Eighth-Final' AND year = 2014 ORDER BY name")"

# Query to list all unique winning team names in the entire dataset
echo -e "\nList of unique winning team names in the whole data set:"
echo "$($PSQL "SELECT DISTINCT(name) FROM teams INNER JOIN games ON teams.team_id = games.winner_id ORDER BY name")"

# Query to get the year and name of the team that won the final round for every year in the dataset (all champions)
echo -e "\nYear and team name of all the champions:"
echo "$($PSQL "SELECT year || '|' || name FROM teams INNER JOIN games ON teams.team_id = games.winner_id WHERE round = 'Final' ORDER BY year")"

# Query to list all teams whose names start with 'Co'
echo -e "\nList of teams that start with 'Co':"
echo "$($PSQL "SELECT name FROM teams WHERE name LIKE 'Co%' ORDER BY name")"